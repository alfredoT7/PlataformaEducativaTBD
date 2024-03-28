package UI;
import BD.ComBD;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class VentanaCredenciales extends JFrame {

    private JPanel panelFunciones;

    public VentanaCredenciales(ComBD conn, InicioDeSesionUI inicioDeSesionUI) {
        setTitle("Detalles del Rol de Usuario");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setPreferredSize(new Dimension(600, 400));
        setResizable(false);

        //panel principalk
        JPanel panelPrincipal = new JPanel(){
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                // Ajusta la imagen de fondo al tamaño del panel
                ImageIcon backgroundImage = new ImageIcon("recursos/fondo.jpg");
                g.drawImage(backgroundImage.getImage(), 0, 0, this.getWidth(), this.getHeight(), null);
            }
        };
        panelPrincipal.setLayout(new BoxLayout(panelPrincipal, BoxLayout.Y_AXIS));
        panelPrincipal.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        JPanel panelNombreRol = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
        JLabel labelNombreRol = new JLabel("Nombre Completo");
        panelNombreRol.add(labelNombreRol);
        panelPrincipal.add(panelNombreRol);

        panelPrincipal.add(Box.createVerticalStrut(5));
        panelPrincipal.add(new JSeparator());
        panelFunciones = new JPanel();
        panelFunciones.setLayout(new BoxLayout(panelFunciones, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(panelFunciones,
                JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
                JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Funciones Permitidas"));
        scrollPane.setPreferredSize(new Dimension(580, 200)); // Puedes ajustar esto según necesites

        panelPrincipal.add(scrollPane);
        panelPrincipal.add(Box.createVerticalStrut(5));

        JButton irAtrasBoton = new JButton("Ir ATRAS");
        irAtrasBoton.setAlignmentX(Component.CENTER_ALIGNMENT);
        panelPrincipal.add(irAtrasBoton);
        getContentPane().add(panelPrincipal);
        pack();
        setLocationRelativeTo(null);

        irAtrasBoton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                inicioDeSesionUI.setVisible(true);
                setVisible(false);
            }
        });
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
            aniadirFuncion(funcion, "Ir...");
        }
    }
}
