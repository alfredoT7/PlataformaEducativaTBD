package BD;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class ComBD {
    //private static final String url="jdbc:postgresql://localhost:5432/Plataforma&Seg";
    private static final String url="jdbc:postgresql://localhost:5432/TBDplatLast";
    private static final String user="postgres";
    private static final String contraseña="notebok456";
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
                //textoQuery.setInt(2,id_sesion);
                textoQuery.setInt(2,PID);
                //se puede cambiar
                textoQuery.setTimestamp(3,new Timestamp(System.currentTimeMillis()));
                textoQuery.setDate(4, new java.sql.Date(System.currentTimeMillis()));
                textoQuery.execute();
                System.out.println("SE LOGRO INSERTAR");
                System.out.println(new java.sql.Date(System.currentTimeMillis()));
                //resultSet.next();
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
        public ArrayList<String> obtener_todas_las_ui(){
            ArrayList<String> listaTodosLasUI = new ArrayList<>();
            PreparedStatement textoQuery = null;
            ResultSet resultSet=null;
            try{
                String consulta = "Select nombre_ui from ui";
                textoQuery=connection.prepareStatement(consulta);
                resultSet=textoQuery.executeQuery();
                while(resultSet.next()){
                    String ui = resultSet.getString("nombre_ui");
                    listaTodosLasUI.add(ui);
                }
            }catch (SQLException e){
                e.printStackTrace();
            }
            return listaTodosLasUI;
        }
        public ArrayList<String> uiNOPermitidas(int id_user){
            ArrayList<String> uiNOPermitidasList= new ArrayList();
            PreparedStatement textoQuery= null;
            ResultSet resultSet= null;
            try {
                String consulta= "select ui_no_permitida(?);";
                textoQuery=connection.prepareStatement(consulta);
                textoQuery.setInt(1,id_user);
                resultSet=textoQuery.executeQuery();
                while(resultSet.next()){
                    String uiNP=resultSet.getString("ui_no_permitida");
                    uiNOPermitidasList.add(uiNP);
                }
            }catch (SQLException e){
                e.printStackTrace();
            }
            return uiNOPermitidasList;
        }
        public ArrayList<String> obtener_nombre_ui_por_usuario(int id_user){
            ArrayList<String> listaFunciones = new ArrayList<>();
            PreparedStatement textoQuery = null;
            ResultSet resultSet = null;
            try{
                String consulta = "select obtener_nombre_ui_por_usuario(?);";
                textoQuery=connection.prepareStatement(consulta);
                textoQuery.setInt(1,id_user);
                resultSet=textoQuery.executeQuery();
                while (resultSet.next()){

                    String funcion = resultSet.getString("obtener_nombre_ui_por_usuario");
                    listaFunciones.add(funcion);
                }

            }catch (SQLException e){
                e.printStackTrace();
            }
            return listaFunciones;
        }
    public String obtenerRolesUsuario(int id_user) {
        ArrayList<String> listaRoles = new ArrayList<>();
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        String res = "";
        try {
            String consulta = "select get_rols(?)";
            textoQuery = connection.prepareStatement(consulta);
            textoQuery.setInt(1, id_user);
            resultSet = textoQuery.executeQuery();
            while (resultSet.next()) {
                String roles = resultSet.getString("get_rols");
                listaRoles.add(roles);
            }

            for (int i = 0; i < listaRoles.size(); i++) {
                if (i < listaRoles.size() - 1) {
                    res = res + listaRoles.get(i) + ", ";
                } else {
                    res = res + listaRoles.get(i);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return res;
    }
    public void insertarMateria(int id_doc, String nombre_mat, String descrip){
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try{
            String consulta="select insertar_materia(?,?,?);";
            textoQuery=connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_doc);
            textoQuery.setString(2,nombre_mat);
            textoQuery.setString(3,descrip);
            textoQuery.execute();
            System.out.println("Materia INSERTADO");
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public ArrayList<String> obtener_materias_por_docente(int id_docente){
        ArrayList<String> listaMateriasxDoc = new ArrayList<>();
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try{
            String consulta="select obtener_materias_por_docente(?);";
            textoQuery=connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_docente);
            resultSet=textoQuery.executeQuery();
            while (resultSet.next()){
                String mat = resultSet.getString("obtener_materias_por_docente");
                listaMateriasxDoc.add(mat);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return listaMateriasxDoc;
    }
    public int crearTarea(String nombreTarea, Date fechaAsignacion, Date fechaEntrega, String descripcionTarea) {
        int tareaId = -1;
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try {
            String consulta = "SELECT insertar_tarea(?, ?, ?, ?)";
            textoQuery = connection.prepareStatement(consulta);
            textoQuery.setString(1, nombreTarea);
            textoQuery.setDate(2, new java.sql.Date(fechaAsignacion.getTime()));
            textoQuery.setDate(3, new java.sql.Date(fechaEntrega.getTime()));
            textoQuery.setString(4, descripcionTarea);

            // Ejecutar la consulta y obtener el id de la tarea.
            resultSet= textoQuery.executeQuery();
            if (resultSet.next()) {
                tareaId = resultSet.getInt(1); // Obtener el primer campo del resultado, que es el id de la tarea.
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tareaId;
    }
    public void insertar_materia_tarea(int id_materia, int id_docente, int id_tarea, String periodo_acad){
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try{
            String consulta="select insertar_materia_tarea(?,?,?,?);";
            textoQuery=connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_materia);
            textoQuery.setInt(2,id_docente);
            textoQuery.setInt(3,id_tarea);
            textoQuery.setString(4,periodo_acad);
            textoQuery.execute();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public ArrayList<String> obtener_nombre_materia_por_estudiante(int id_est){
        ArrayList<String> listaMateriasInscrito = new ArrayList<>();
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try {
            String consulta="select obtener_nombre_materia_por_estudiante(?);";
            textoQuery=connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_est);
            resultSet=textoQuery.executeQuery();
            while (resultSet.next()) {
                String mat = resultSet.getString("obtener_nombre_materia_por_estudiante");
                listaMateriasInscrito.add(mat);
            }
        }catch (SQLException e ){e.printStackTrace();}
        return listaMateriasInscrito;
    }
    public ArrayList<String> obtener_materia_docente_por_estudiante_excluyendo(int id_est){
        ArrayList<String> listaMateriasNoInscrito = new ArrayList<>();
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try{
            String consulta="select obtener_materia_docente_por_estudiante_excluyendo(?)";
            textoQuery=connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_est);
            resultSet=textoQuery.executeQuery();
            while (resultSet.next()) {
                String mat = resultSet.getString("obtener_materia_docente_por_estudiante_excluyendo");
                listaMateriasNoInscrito.add(mat);
            }
        }catch (SQLException e){e.printStackTrace();}
        return listaMateriasNoInscrito;
    }
    public void insertar_inscripcion(int id_materia, int id_docente, int id_est, String periodo_acad){
        PreparedStatement textoQuery = null;
        ResultSet resultSet = null;
        try{
            String consulta="select insertar_inscripcion(?, ?, ?, ?);";
            textoQuery= connection.prepareStatement(consulta);
            textoQuery.setInt(1,id_materia);
            textoQuery.setInt(2,id_docente);
            textoQuery.setInt(3,id_est);
            textoQuery.setString(4,periodo_acad);
            textoQuery.execute();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

}


