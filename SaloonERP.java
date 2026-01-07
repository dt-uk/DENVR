public class SaloonERP {
    private String[] modules = {"HR", "Finance", "Sales"};
    
    public void displayInfo() {
        System.out.println("Saloon ERP System");
        System.out.println("=================");
        for (String module : modules) {
            System.out.println("- " + module);
        }
    }
    
    public static void main(String[] args) {
        SaloonERP erp = new SaloonERP();
        erp.displayInfo();
    }
}
