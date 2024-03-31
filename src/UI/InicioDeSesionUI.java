package UI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import BD.ComBD;

public class InicioDeSesionUI extends JFrame {
    private JTextField usuarioField;
    private JTextField contraseñaField;

    public InicioDeSesionUI(HomeBaseDeDatos login, ComBD conn) {
        setTitle("UsuariosBD");
        setSize(600, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);

        ImageIcon backgroundImage = new ImageIcon("recursos/fondo.jpg");
        JLabel backgroundLabel = new JLabel(backgroundImage);
        setContentPane(backgroundLabel);
        setLayout(new BorderLayout());

        JPanel panelDeVentana = new JPanel(new GridBagLayout());
        panelDeVentana.setOpaque(false);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.gridx = 0;
        gbc.gridy = 0;
        JLabel usuarioLabel = new JLabel("Usuario:");
        usuarioLabel.setForeground(Color.WHITE);
        panelDeVentana.add(usuarioLabel, gbc);
        gbc.gridx = 1;
        gbc.gridy = 0;
        usuarioField = new JTextField(15);
        panelDeVentana.add(usuarioField, gbc);
        gbc.gridx = 0;
        gbc.gridy = 1;
        JLabel contraseñaLabel = new JLabel("Contraseña:");
        contraseñaLabel.setForeground(Color.WHITE);
        panelDeVentana.add(contraseñaLabel, gbc);
        gbc.gridx = 1;
        gbc.gridy = 1;
        contraseñaField = new JPasswordField(15);
        panelDeVentana.add(contraseñaField, gbc);

        JPanel panelDeBoton = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 10));
        JButton okBoton = new JButton("OK");
        JButton cancelarBoton = new JButton("Cancelar");
        okBoton.setBackground(new Color(27, 161, 27));
        cancelarBoton.setBackground(new Color(255, 69, 0));
        panelDeBoton.setOpaque(false);
        panelDeBoton.add(okBoton);
        panelDeBoton.add(cancelarBoton);

        add(panelDeVentana, BorderLayout.CENTER);
        add(panelDeBoton, BorderLayout.SOUTH);

        okBoton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                if(conn.verificarInicioSesion(usuarioField.getText(),contraseñaField.getText())>0){
                    int id_usr=conn.verificarInicioSesion(usuarioField.getText(),contraseñaField.getText());
                    //System.out.println(id_usr);
                    int aPID=conn.getPID();
                    System.out.println(aPID);
                    conn.insertarPIDEnSesion(aPID,id_usr);
                    JOptionPane.showMessageDialog(InicioDeSesionUI.this, "usuario encontrado");
                    //Alf ventanaUIS de credenciales
                    ArrayList<String> listafunciones= conn.obtener_nombre_ui_por_usuario(id_usr);
                    String rolesDelUsuarioSTR= conn.obtenerRolesUsuario(id_usr);
                    VentanaCredenciales ventanaCredenciales= new VentanaCredenciales(conn,InicioDeSesionUI.this,usuarioField.getText(),rolesDelUsuarioSTR);
                    System.out.println(rolesDelUsuarioSTR);
                    ventanaCredenciales.cargarFunciones(listafunciones);
                    ventanaCredenciales.pack();
                    ventanaCredenciales.setLocationRelativeTo(null);
                    ventanaCredenciales.setVisible(true);
                    setVisible(false);
                }else{
                    JOptionPane.showMessageDialog(InicioDeSesionUI.this, "usuario NO encontrado, contraseña o nombre incorrectos");
                }
            }
        });
        cancelarBoton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                login.setVisible(true);
                dispose();
            }
        });
    }
}