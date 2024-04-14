import BD.ComBD;
import UI.HomeBaseDeDatos;
public class Main {

    public static void main(String[] args){
        HomeBaseDeDatos login1 = new HomeBaseDeDatos();
        //HomeBaseDeDatos login = new HomeBaseDeDatos();
        //HomeBaseDeDatos login3 = new HomeBaseDeDatos();
        ComBD conexion = new ComBD();
        conexion.getConnection();
        System.out.println("conectaasdadosasdasdasdasdasdasd");
    }
}



