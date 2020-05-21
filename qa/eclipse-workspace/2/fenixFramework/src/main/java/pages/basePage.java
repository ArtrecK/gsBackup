package pages;

import java.util.List;

import org.apache.bcel.generic.Select;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

public class basePage {
	
	public final int timeout=30;
	protected static WebDriver driver;
	private static WebDriverWait wait;
	private Actions action;
	private List<WebElement> elements;
	private Select dropdown;
	public static JavascriptExecutor js;
	
	//Constructor
	public basePage(WebDriver driver){
		System.out.println("basePage");
		this.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WebDriverWait(driver, timeout);
		action = new Actions(driver);
		this.js = (JavascriptExecutor) driver;
	}
	
	public static WebElement getElementByXPathContainsText(String xpath) {
		return driver.findElement(By.xpath(xpath));
	}
	
	protected void sendKeys(WebElement element,String text) {
		//waitForElement(element); //**No descomentar, por que cuando se descomenta, no funciona oportunidades nuevo :(
		//element.clear();
		element.sendKeys(text);			
	}

}
