package pages;

import java.util.List;
import org.apache.bcel.generic.Select;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class basePage {

	public final static int timeout = 10;
	protected static WebDriver driver;
	private static WebDriverWait wait;
	private Actions action;
	private List<WebElement> elements;
	private Select dropdown;
	public static JavascriptExecutor js;

	public basePage(WebDriver driver) {
		this.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WebDriverWait(driver, timeout);
		action = new Actions(driver);
		this.js = (JavascriptExecutor) driver;
	}

	public static WebElement getElementByXPathContainsText(String xpath) {
		return driver.findElement(By.xpath(xpath));
	}

	protected void sendKeys(WebElement element, String text) {
		element.sendKeys(text);
	}

	protected void click(WebElement element) {
		try {
			waitTimeOut(element);
		} catch (Exception e) {
			System.out.println("No fue posible dar click " + e);
		}
	}

	protected static void waitTimeOut(WebElement element) throws InterruptedException {
		wait.wait(timeout);
	}

}
