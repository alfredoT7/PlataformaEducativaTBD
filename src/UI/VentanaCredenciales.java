package UI;
import BD.ComBD;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

public class VentanaCredenciales extends JFrame {

    private JPanel panelFunciones;

    public VentanaCredenciales(ComBD conn, InicioDeSesionUI inicioDeSesionUI) {
        setTitle("Detalles del Rol de Usuario");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setPreferredSize(new Dimension(600, 400));
        setResizable(false);
        //panel principalk
        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        JPanel panelNombreRol = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        JLabel labelNombreRol = new JLabel("Nombre: Rol");
        panelNombreRol.add(labelNombreRol);
        mainPanel.add(panelNombreRol);

        mainPanel.add(Box.createVerticalStrut(5));
        mainPanel.add(new JSeparator());
        panelFunciones = new JPanel();
        panelFunciones.setLayout(new BoxLayout(panelFunciones, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(panelFunciones,
                JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
                JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Funciones Permitidas"));
        scrollPane.setPreferredSize(new Dimension(580, 200)); // Puedes ajustar esto según necesites

        mainPanel.add(scrollPane);
        mainPanel.add(Box.createVerticalStrut(5));

        JButton irAtras = new JButton("Ir al HOME");
        irAtras.setAlignmentX(Component.CENTER_ALIGNMENT);
        mainPanel.add(irAtras);

        getContentPane().add(mainPanel);
        pack();
        setLocationRelativeTo(null);
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
        panel.add(label);
        panel.add(boton);
        return panel;
    }
    public void cargarFunciones(ArrayList<String> funciones) {
        panelFunciones.removeAll();
        for (String funcion : funciones) {
            aniadirFuncion(funcion, "Ir");
        }
    }
}
