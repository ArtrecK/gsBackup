package tests;

import java.io.IOException;
import java.util.ArrayList;

import org.testng.annotations.Test;

import pages.busquedaPage;


public class TbarraBusqueda extends baseTest{

    @Test
    public static void barraBusqueda() throws IOException{
        System.out.println("TbarraBusqueda");
        
        busquedaPage busqueda = new busquedaPage(driver);
        ArrayList<String> paso = new ArrayList();
        ArrayList<String> status = new ArrayList();
        try{
            busqueda.inputClienteUnico();
        }catch(Exception e){
            System.out.println("Something went wrong.");
        }
        
    }

}
