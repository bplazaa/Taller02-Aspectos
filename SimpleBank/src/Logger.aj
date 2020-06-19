import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Calendar;

aspect Logger{
	

	File file = new File("log2.txt" );
	
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* *Transaction() );
    after() : success() {
    	String fecha = cal.getTime().toString();
    	try {
    		if(!file.exists()){
    			file.createNewFile();
    		}
	    	FileWriter fw = new FileWriter(file.getAbsoluteFile(), true);
	    	BufferedWriter bf = new BufferedWriter(fw);
	    	bf.write("Transacción: Deposito - Fecha: "+ fecha+ "\n");
	    	bf.close();
    	}catch(Exception e){
    		System.out.println("Ha ocurrido un error");
    	}
    	System.out.println("**** Transacción exitosa en la fecha: "+fecha +"****\n");

    }
    
    pointcut success_retire() : call(* *drawal() );
    after() : success_retire() {
    	String fecha = cal.getTime().toString();
    	try {
    		if(!file.exists()){
    			file.createNewFile();
    		}
	    	FileWriter fw = new FileWriter(file.getAbsoluteFile(), true);
	    	BufferedWriter bf = new BufferedWriter(fw);
	    	bf.write("Transacción: Retiro - Fecha: "+ fecha+ "\n");
	    	bf.close();
    	}catch(Exception e){
    		System.out.println("Ha ocurrido un error");
    	}
    	System.out.println("**** Transacción exitosa en la fecha: "+fecha +"****\n");

    }
    
    //Ejemplo
    pointcut success_add() : call(* create*(..) );
    after() : success_add() {
    	System.out.println("**** User created ****");
    }
	
}