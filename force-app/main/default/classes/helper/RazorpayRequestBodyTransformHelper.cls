public with sharing class RazorpayRequestBodyTransformHelper {

    public static String transform(Object input){
        Map<String, Object> cleanMap = removeNullValuePairs(input);
        return replacer(cleanMap);
    }

    private static String replacer(Object input){
        return JSON.serialize(input).replace('currencyValue', 'currency')
                                    .replace('endValue', 'end')
                                    .replace('beginValue', 'begin');
    }

    private static Map<String, Object> removeNullValuePairs(Object input) {
        Map<String, Object> inputMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(input));
        return cleanMap(inputMap);
    }

    // Recursively clean nulls inside nested maps or lists
    private static Map<String, Object> cleanMap(Map<String, Object> data) {
        for (String key : new List<String>(data.keySet())) {
            Object value = data.get(key);
            
            if (value == null) {
                data.remove(key);
            } else if (value instanceof Map<String, Object>) {
                data.put(key, cleanMap((Map<String, Object>) value));
            } else if (value instanceof List<Object>) {
                data.put(key, cleanList((List<Object>) value));
            }
        }
        return data;
    }

    private static List<Object> cleanList(List<Object> dataList) {
        List<Object> cleanedList = new List<Object>();
        for (Object item : dataList) {
            if (item == null) continue;
            if (item instanceof Map<String, Object>) {
                cleanedList.add(cleanMap((Map<String, Object>) item));
            } else {
                cleanedList.add(item);
            }
        }
        return cleanedList;
    }
}
