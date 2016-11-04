/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */

//Clase para crear funciones que puedan ser reutilizables 
public class FuncionesApoyo {
    //Convertir fecha a string
    public String FechaAString(Date date, String format) {
        String dateStr = null;
        DateFormat df = new SimpleDateFormat(format);
        try {
            dateStr = df.format(date);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return dateStr;
    }

    //Convertir string a fecha    
public Date StringAFecha(String dateStr, String format) {
        Date date = null;
        DateFormat df = new SimpleDateFormat(format);
        try {
            date = df.parse(dateStr);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return date;
    }    
}
