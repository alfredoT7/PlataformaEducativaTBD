package BD;

import java.sql.*;
import java.util.Random;

public class ComBD {
    private static final String url = "jdbc:postgresql://localhost:5432/Validacion";
    private static final String user = "alfredo";
    private static final String contraseña = "notebok456";
    private Connection connection;

    public ComBD() {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(url, user, contraseña);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public int verificarInicioSesion(String usuario, String contraseña) {
        PreparedStatement textoQuery = null;
        ResultSet resultSet =null;
        int id_user=-1;
        try {
            String consulta1 = "SELECT get_id_usuario22(?,?)";//"Select id_user from usern where nombre =? and contrasena =?";
            textoQuery = connection.prepareStatement(consulta1);
            textoQuery.setString(1, usuario);
            textoQuery.setString(2, contraseña);
            resultSet = textoQuery.executeQuery();
            resultSet.next();
            id_user = resultSet.getInt(1);
            return id_user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
        public int registrarUsuario(String nuevoUser, String contra ,String confirContra){
            PreparedStatement textoQuery = null;
            Random rand = new Random();
            int a=rand.nextInt(10000)+1;
            if(contra.equals(confirContra)){
                try{
                    String consulta = "Select insertar_usuario_natural(?,?,?);";
                    textoQuery= connection.prepareStatement(consulta);
                    textoQuery.setInt(1,a);
                    textoQuery.setString(2, nuevoUser);
                    textoQuery.setString(3, contra);
                    textoQuery.execute();
                    return 1;//cod "1" valido para hacer las siguientes operaciones
                    //return -1;
                }catch (SQLException e){
                        e.getNextException();
                        return -1; //error de SQL
                }
            }else{
                return -2;//-2 codigo para contraseñas no coinciden
            }
        }
        public boolean existeNombreRegistro(String nombreObtenido){
            PreparedStatement textoQuery=null;
            ResultSet resultSet=null;
            boolean res=false;
            try{
                String consulta="Select nombre_usern1(?)";
                textoQuery=connection.prepareStatement(consulta);
                textoQuery.setString(1,nombreObtenido);
                resultSet=textoQuery.executeQuery();
                resultSet.next();
                if(nombreObtenido.equalsIgnoreCase(resultSet.getString(1))){
                    res=true;
                    return res;
                }
            }catch (SQLException e){
                e.printStackTrace();
            }
            return res;
        }
        public int getPID(){
            PreparedStatement textoQuery=null;
            ResultSet resultSet=null;
            try {
                String consulta = "SELECT pg_backend_pid();";
                textoQuery = connection.prepareStatement(consulta);
                resultSet= textoQuery.executeQuery();
                resultSet.next();
                return resultSet.getInt(1);
            }catch (SQLException e){
                e.printStackTrace();
            }
            return -1;
        }
        public void insertarPIDEnSesion(int PID, int id_user){
            PreparedStatement textoQuery=null;
            ResultSet resultSet=null;
            Random rand = new Random();
            int id_sesion= rand.nextInt(10000)+1;
            try{
                String consulta = "select insertar_sesion(?,?,?,?);";
                textoQuery=connection.prepareStatement(consulta);
                textoQuery.setInt(1,id_user);
                textoQuery.setInt(2,id_sesion);
                textoQuery.setInt(3,PID);
                //se puede cambiar
                textoQuery.setTimestamp(4,new Timestamp(System.currentTimeMillis()));
                textoQuery.execute();
                //resultSet.next();
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
}