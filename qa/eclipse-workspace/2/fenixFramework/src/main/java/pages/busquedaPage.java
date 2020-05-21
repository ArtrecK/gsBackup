package pages;

import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.testng.annotations.Test;

import helpers.*;

public class busquedaPage extends basePage{

    @FindBy(xpath="//*[@id=\"inputSearch\"]")
    WebElement txCU;

    private String url = Hproperties.strUrl;
    public ArrayList<String> paso = new ArrayList();
    public ArrayList<String> status = new ArrayList();

    public busquedaPage(WebDriver driver){
        super(driver);
    }

    public void launchhome(){
        try{
            driver.get(url);
            paso.add("Lanzando Pagina en busquedaPage");
            status.add("OK");
        }catch(Exception e){
            status.add("FAILED");
        }
    }

    @Test
    public void inputClienteUnico(){
        inputCU();
    }

    private void inputCU() {
        try{
            System.out.println("El cliente unico es: "+Hproperties.strCU);
            paso.add("IngresandoCU");
            driver.findElement(By.cssSelector("#inputSearch")).click();
            sendKeys(txCU, Hproperties.strCU);
            status.add("OK");
            driver.findElement(By.cssSelector("body > app-root > app-pantalla-principal > app-barra-url > div > div.toplinks > table > tbody > tr > td:nth-child(1) > a > div")).click();
            //#inputSearch
        }catch(Exception e){
            status.add("FAILED");
        }
    }
}
