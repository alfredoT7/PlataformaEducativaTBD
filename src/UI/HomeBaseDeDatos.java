package UI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

import BD.ComBD;
import UI.*;

public class HomeBaseDeDatos extends JFrame {
    private ComBD conn= new ComBD();
    public HomeBaseDeDatos() {
        setTitle("Opciones de Sesión");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(600, 500);
        setLocationRelativeTo(null);
        setResizable(false);
        JPanel panel = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon imageIcon = new ImageIcon("E:/1/A.jpg");
                Image image = imageIcon.getImage();
                g.drawImage(image, 0, 0, getWidth(), getHeight(), this);
            }
        };
        panel.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = GridBagConstraints.RELATIVE;
        gbc.insets = new Insets(10, 10, 10, 10);
        JLabel tituloLabel = new JLabel("Base de DATOS");
        tituloLabel.setHorizontalAlignment(SwingConstants.CENTER);
        tituloLabel.setForeground(Color.WHITE);
        panel.add(tituloLabel, gbc);

        JButton iniciarSesionBoton = new JButton("Iniciar Sesion");
        iniciarSesionBoton.setPreferredSize(new Dimension(150, 30));
        iniciarSesionBoton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                InicioDeSesionUI vt=new InicioDeSesionUI(HomeBaseDeDatos.this,conn);
                vt.setVisible(true);
                setVisible(false);
            }
        });
        panel.add(iniciarSesionBoton, gbc);
        /*
        JButton registrarseBoton = new JButton("Registrarse");
        registrarseBoton.setPreferredSize(new Dimension(150, 30));
        registrarseBoton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
               RegistroUI reg = new RegistroUI(HomeBaseDeDatos.this,conn);
               reg.setVisible(true);
               dispose();
            }
        });
        panel.add(registrarseBoton, gbc);
        */
        add(panel);
        setVisible(true);
    }
}
