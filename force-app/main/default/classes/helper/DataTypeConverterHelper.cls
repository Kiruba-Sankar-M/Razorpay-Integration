public class DataTypeConverterHelper {
    public static Date toDate(Object input) {
        try { return Date.valueOf(String.valueOf(input)); } catch (Exception e) { return null; }
    }
    public static Datetime toDateTime(Object input) {
        try { return Datetime.valueOf(String.valueOf(input)); } catch (Exception e) { return null; }
    }
    public static Decimal toDecimal(Object input) {
        try { return Decimal.valueOf(String.valueOf(input)); } catch (Exception e) { return null; }
    }
    public static Double toDouble(Object input) {
        try { return Double.valueOf(String.valueOf(input)); } catch (Exception e) { return null; }
    }
    public static Integer toInteger(Object input) {
        try { return Integer.valueOf(String.valueOf(input)); } catch (Exception e) { return null; }
    }
    public static Boolean toBoolean(Object input) {
        try {
            if (input instanceof Boolean) return (Boolean) input;
            String val = String.valueOf(input).toLowerCase();
            return val == 'true' || val == '1' || val == 'yes';
        } catch (Exception e) { return null; }
    }
}
