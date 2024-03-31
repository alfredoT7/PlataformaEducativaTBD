import BD.ComBD;
import UI.HomeBaseDeDatos;
public class Main {

    public static void main(String[] args){
        HomeBaseDeDatos login = new HomeBaseDeDatos();
        ComBD conexion = new ComBD();
        conexion.getConnection();
        System.out.println("conectaasdadosasdasdasdasdasdasd");
    }
}



