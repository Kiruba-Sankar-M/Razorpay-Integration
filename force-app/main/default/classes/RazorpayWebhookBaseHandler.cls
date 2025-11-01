public with sharing class RazorpayWebhookBaseHandler implements IRazorpayWebhookHandler {
    
    public void handle(RazorpayWebhookEntity event) {
        if (String.isBlank(event.event)) {
            throw new AuraHandledException('Invalid webhook event type.');
        }

        List<Webhook_Field_Mapping__mdt> mappings = [
            SELECT Object_Api_Name__c, Field_Api_Name__c,
                   Source_Field_Path__c, Is_External_Field__c
            FROM Webhook_Field_Mapping__mdt
            WHERE Payment_Webhook_Event__r.MasterLabel = :event.event
            AND Object_Api_Name__c != NULL 
            AND Field_Api_Name__c != NULL
        ];
        System.debug('mappings ' + mappings);

        if (mappings.isEmpty()) return;

        Map<String, List<Webhook_Field_Mapping__mdt>> grouped = new Map<String, List<Webhook_Field_Mapping__mdt>>();
        for (Webhook_Field_Mapping__mdt m : mappings) {
            if (String.isBlank(m.Object_Api_Name__c)) continue;
            if (!grouped.containsKey(m.Object_Api_Name__c)) {
                grouped.put(m.Object_Api_Name__c, new List<Webhook_Field_Mapping__mdt>());
            }
            grouped.get(m.Object_Api_Name__c).add(m);
        }

        // Prepare record and external ID maps
        Map<String, SObject> recordMap = new Map<String, SObject>();
        Map<String, String> externalIdMap = new Map<String, String>();
        System.debug('grouped ' + grouped);
        // Build SObjects dynamically
        for (String objName : grouped.keySet()) {
            Schema.SObjectType objType = Schema.getGlobalDescribe().get(objName);
            if (objType == null) continue;

            Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();
            SObject record = objType.newSObject();
            String externalIdField;

            for (Webhook_Field_Mapping__mdt mapRec : grouped.get(objName)) {
                if (String.isBlank(mapRec.Field_Api_Name__c) || !fieldMap.containsKey(mapRec.Field_Api_Name__c)) continue;

                Object rawValue = resolveFieldPath(event, mapRec.Source_Field_Path__c);

                if (rawValue != null) {
                    assignConvertedValue(record, fieldMap.get(mapRec.Field_Api_Name__c), mapRec.Field_Api_Name__c, rawValue);
                }

                if (mapRec.Is_External_Field__c) {
                    externalIdField = mapRec.Field_Api_Name__c;
                }
            }

            recordMap.put(objName, record);
            if (!String.isBlank(externalIdField)) {
                externalIdMap.put(objName, externalIdField);
            }
        }

        performDml(recordMap, externalIdMap);
    }

    public virtual void performDml(Map<String, SObject> recordsMap, Map<String, String> externalIdMap) {
        for (String objName : recordsMap.keySet()) {
            SObject record = recordsMap.get(objName);
            System.debug('record ' + record);
            String externalIdField = externalIdMap.get(objName);

            if (!String.isBlank(externalIdField)) {
                Schema.SObjectType objType = record.getSObjectType();
                Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();

                if (fieldMap.containsKey(externalIdField)) {
                    Database.upsert(new List<SObject>{record}, fieldMap.get(externalIdField));
                } else {
                    insert record;
                }
            } else {
                insert record;
            }
        }
    }

    private static void assignConvertedValue(SObject record, Schema.SObjectField field, String fieldApiName, Object rawValue) {
        Schema.DescribeFieldResult describe = field.getDescribe();
        Schema.DisplayType type = describe.getType();
        try {
            switch on type {
                when DATE {
                    record.put(fieldApiName, DataTypeConverterHelper.toDate(rawValue));
                }
                when DATETIME {
                    record.put(fieldApiName, DataTypeConverterHelper.toDateTime(rawValue));
                }
                when DOUBLE {
                    record.put(fieldApiName, DataTypeConverterHelper.toDouble(rawValue));
                }
                when CURRENCY {
                    record.put(fieldApiName, DataTypeConverterHelper.toDecimal(rawValue));
                }
                when INTEGER {
                    record.put(fieldApiName, DataTypeConverterHelper.toInteger(rawValue));
                }
                when BOOLEAN {
                    record.put(fieldApiName, DataTypeConverterHelper.toBoolean(rawValue));
                }
                when else {
                    record.put(fieldApiName, String.valueOf(rawValue));
                }
            }
        } catch (Exception e) {
            System.debug('⚠️ Skipped field ' + fieldApiName + ' due to conversion error: ' + e.getMessage());
        }
    }

    private static Object resolveFieldPath(Object base, String path) {
        System.debug('base '  + base);
        System.debug('path ' + path);
        if (String.isBlank(path) || base == null) return null;
        List<String> parts = path.split('\\.');
        Object current = base;
        for (String p : parts) {
            if (current == null) return null;
            Map<String, Object> mapVal = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(current));
            Object nextVal = mapVal.get(p);
            if (nextVal == null) return null;
            if (p.toLowerCase() == 'notes') {
                return JSON.serialize(nextVal);
            }
            current = nextVal;
        }
        System.debug('current ' + current);
        return current;
    }
}
