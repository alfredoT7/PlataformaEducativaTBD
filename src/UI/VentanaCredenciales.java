package UI;
import BD.ComBD;
import UI.PostCredenciales.Docente.CrearClaseVirtualUI;
import UI.PostCredenciales.Docente.MostrarMateriasDictadasUI;
import UI.PostCredenciales.Estudiante.InscripcionMateriaUI;
import UI.PostCredenciales.Estudiante.VerClasesInscritoUI;
//import UI.PostCredenciales.*;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class VentanaCredenciales extends JFrame {

    private JPanel panelFunciones;
    private Map<String, Runnable> acciones;
    private int id_user;
    private ComBD conn;
    //private ArrayList<String> listaUINoPermitidas;
    //ComBD conn;
    HomeBaseDeDatos login;
    public VentanaCredenciales(ComBD conn, InicioDeSesionUI inicioDeSesionUI, String nombreUser, String rolesDelUsuarioStr, HomeBaseDeDatos login, ArrayList<String> listaUIPermitidas, ArrayList<String> listaUINOPermitidas,int id_user) {
        this.id_user=id_user;
        this.conn = conn;
        this.login = login;
        setLocationRelativeTo(null);
        setTitle("Detalles del Rol de Usuario");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setPreferredSize(new Dimension(600, 400));
        setResizable(false);

        JPanel panelPrincipal = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon backgroundImage = new ImageIcon("recursos/a.jpg");
                g.drawImage(backgroundImage.getImage(), 0, 0, this.getWidth(), this.getHeight(), null);
            }
        };
        panelPrincipal.setLayout(new BoxLayout(panelPrincipal, BoxLayout.Y_AXIS));
        panelPrincipal.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));


        JPanel panelNombreRol = new JPanel(new FlowLayout(FlowLayout.CENTER, 0, 0));
        JLabel labelNombreRol = new JLabel("Usuario: " + nombreUser + "\n" + "           " + "Roles: " + rolesDelUsuarioStr);
        panelNombreRol.add(labelNombreRol);
        panelPrincipal.add(panelNombreRol);

        panelPrincipal.add(Box.createVerticalStrut(5));
        panelPrincipal.add(new JSeparator());

        panelFunciones = new JPanel();
        panelFunciones.setLayout(new BoxLayout(panelFunciones, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(panelFunciones, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Funciones Permitidas"));
        scrollPane.setPreferredSize(new Dimension(580, 200));
        panelPrincipal.add(scrollPane);
        panelPrincipal.add(Box.createVerticalStrut(5));

        JButton volverBoton = new JButton("Volver al Home");
        volverBoton.setAlignmentX(Component.CENTER_ALIGNMENT);
        panelPrincipal.add(volverBoton);
        getContentPane().add(panelPrincipal);
        pack();
        setLocationRelativeTo(null);
        volverBoton.addActionListener(e -> {
            HomeBaseDeDatos newHome = new HomeBaseDeDatos();
            newHome.setVisible(true);
            setVisible(false);
            eliminarInstancias();
        });
        acciones = new HashMap<>();
        inicializarAcciones(listaUIPermitidas);
        cargarFunciones(listaUIPermitidas,listaUINOPermitidas);
    }

    private void eliminarInstancias() {
        login = null;
        conn = null;
        System.gc();
    }
    private void inicializarAcciones(ArrayList<String> listaUINoPermitidas) {
        for (String uiPermitida : listaUINoPermitidas) {
            if (!uiPermitida.equals("Inhabilitado...")) {
                acciones.put(uiPermitida, () -> abrirVentanaParaFuncion(uiPermitida));
            }
        }
    }

    private void abrirVentanaParaFuncion(String funcion) {
        JFrame ventana = null;
        switch (funcion) {
            case "Actualizar Datos Personales":
                break;
            case "Ver Detalles de Tarea":
                break;
            case "Ver Clases Inscrito":
                VerClasesInscritoUI verClasesInscritoUI= new VerClasesInscritoUI(conn,id_user);
                break;
            case "Ver Detalles Materia":
                break;
            case "Crear Clase Virtual":
                CrearClaseVirtualUI cv = new CrearClaseVirtualUI(conn, id_user,VentanaCredenciales.this);
                cv.setVisible(true);
                this.setVisible(false);
                break;
            case "Mostrar Detalles de Materia":
                break;
            case "Mostrar Materias Dictadas":
                ArrayList<String> listaMateriasDictadas = new ArrayList<>();
                listaMateriasDictadas=conn.obtener_materias_por_docente(id_user);
                MostrarMateriasDictadasUI mostrarMateriasDictadasUI = new MostrarMateriasDictadasUI(listaMateriasDictadas,this,conn, id_user);
                setVisible(false);
                mostrarMateriasDictadasUI.setVisible(true);
                break;
            case "Crear Usuario Estudiante":
                break;
            case "Crear Usuario Docente":
                break;
            case "Opciones Modificacion Usuario":
                break;
            case "Buscar Usuarios":
                break;
            case "Generar Reportes del Alumno":
                break;
            case "Ver Datos del Estudiante":
                break;
            case "Inscripcion Materia":
                InscripcionMateriaUI inscripcionMateriaUI = new InscripcionMateriaUI(conn,id_user,this);
                setVisible(false);
                inscripcionMateriaUI.setVisible(true);
                break;

        }

    }
    public void cargarFunciones(ArrayList<String> listaUIPermitidas, ArrayList<String> listaUINoPermitidas) {
        panelFunciones.removeAll();
        for (String funcion : listaUIPermitidas) {
            aniadirFuncion(funcion, "Ir...");
        }
        for (String funcion : listaUINoPermitidas) {
            aniadirFuncion(funcion, "Inhabilitado...");
        }
        panelFunciones.revalidate();
        panelFunciones.repaint();
    }
    public void aniadirFuncion(String nombreFuncion, String textoBoton) {
        JPanel panel = crearPanelFuncion(nombreFuncion, textoBoton);
        panelFunciones.add(panel);
        panelFunciones.revalidate();
        panelFunciones.repaint();
    }
    private JPanel crearPanelFuncion(String nombreFuncion, String textoBoton) {
        JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout(FlowLayout.CENTER));
        JLabel label = new JLabel(nombreFuncion);
        JButton boton = new JButton(textoBoton);
        if (!"Inhabilitado...".equals(textoBoton)) {
            boton.addActionListener(e -> {
                Runnable accion = acciones.get(nombreFuncion);
                if (accion != null) {
                    accion.run();
                }
            });
        } else {
            boton.setEnabled(false);
            boton.setForeground(Color.GRAY);
        }
        panel.add(label);
        panel.add(boton);
        return panel;
    }

}
