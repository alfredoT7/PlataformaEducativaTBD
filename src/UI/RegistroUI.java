package UI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import BD.ComBD;
/*
El registro de este codigo tiene que complementarse, faltan demasiados campos para lograr este objetivo, por lo tanto intentamos solucionarlo
en los días que vendran, por el momento la propuesta se quedará en pie.
 */
public class RegistroUI extends JFrame {
    private JTextField usuarioField;
    private JTextField contraseñaField;
    private JTextField confirmarContraseñaField;

    public RegistroUI(HomeBaseDeDatos pantPrin, ComBD conn) {
        setTitle("Registro");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setResizable(false);
        ImageIcon backgroundImage = new ImageIcon("E:/1/app.jpg");
        JLabel backgroundLabel = new JLabel(backgroundImage);
        setContentPane(backgroundLabel);
        setLayout(new BorderLayout());
        JPanel panelDeVentana = new JPanel(new GridBagLayout());
        panelDeVentana.setOpaque(false);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.gridx = 0;
        gbc.gridy = 0;
        JLabel usuarioLabel = new JLabel("Nombre de usuario:");
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
        gbc.gridx = 0;
        gbc.gridy = 2;
        JLabel confirmarContraseñaLabel = new JLabel("Confirmar Contraseña:");
        confirmarContraseñaLabel.setForeground(Color.WHITE);
        panelDeVentana.add(confirmarContraseñaLabel, gbc);
        gbc.gridx = 1;
        gbc.gridy = 2;
        confirmarContraseñaField = new JPasswordField(15);
        panelDeVentana.add(confirmarContraseñaField, gbc);

        JPanel panelDeBoton = new JPanel(new FlowLayout(FlowLayout.CENTER, 20, 10));
        JButton registrarseBoton = new JButton("Registrarse");
        JButton cancelarBoton = new JButton("Cancelar");
        registrarseBoton.setBackground(new Color(27, 161, 27));
        cancelarBoton.setBackground(new Color(255, 69, 0));
        panelDeBoton.setOpaque(false);
        panelDeBoton.add(registrarseBoton);
        panelDeBoton.add(cancelarBoton);

        add(panelDeVentana, BorderLayout.CENTER);
        add(panelDeBoton, BorderLayout.SOUTH);

        registrarseBoton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                //registrarUsuario(usuarioField.getTex(), contraseñaField.getText(), confirmarContraseñaField.getText(),pantPrin);
                if(!conn.existeNombreRegistro(usuarioField.getText())){
                    int a = conn.registrarUsuario(usuarioField.getText(), contraseñaField.getText(), confirmarContraseñaField.getText());
                    System.out.println(a+"Es el numero");
                    if(a==1){
                        JOptionPane.showMessageDialog(RegistroUI.this, "Usuario registrado con éxito.");
                    }else{
                        if(a==-1) {
                            JOptionPane.showMessageDialog(RegistroUI.this, "ERROR SQL");
                        }
                        if(a==-2){
                            JOptionPane.showMessageDialog(RegistroUI.this, "Las contraseñas no coinciden");
                        }
                    }
                }else{
                    JOptionPane.showMessageDialog(RegistroUI.this, "NOMBRE USUARIO EXISTENTE");
                }
            }
        });
        cancelarBoton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                pantPrin.setVisible(true);
                dispose();
            }
        });
    }

}