package tests;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.Select;
import org.testng.annotations.Test;

import pages.homePage;

public class TcomboSelection extends baseTest{
	
	@Test
	public static void comboSelectionOp() throws IOException{
		System.out.println("TcomboSelection");
		homePage home = new homePage(driver);

		home.launchHome();
		driver.findElement(By.cssSelector("#dk0-combobox")).click();
		Select select = new Select(driver.findElement(By.id("dk0-listbox")));
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		driver.findElement(By.cssSelector("#dk0-normal_select")).click();
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		driver.findElement(By.cssSelector("#dk0-2\3a -Object")).click();
		select.selectByVisibleText("");
	}
}

/*
body > app-root > app-layout-vendedor > div > app-content-vendedor > div > div.content-center > app-clients > div > div > app-overview-with-order > div

/html/body/app-root/app-layout-vendedor/div/app-content-vendedor/div/div[2]/app-clients/div/div/app-overview-with-order/div
*/