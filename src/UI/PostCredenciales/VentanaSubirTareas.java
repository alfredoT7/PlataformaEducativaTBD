package UI.PostCredenciales;

import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

public class VentanaSubirTareas extends JFrame {
        private JButton btnSubirArchivo;
        private JLabel lblArchivoSeleccionado;

        public VentanaSubirTareas() {
            setLocationRelativeTo(null);
            setTitle("Subir Tareas");
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            setSize(new Dimension(600, 400));
            setResizable(false);

            // Inicializar componentes de la UI
            initUI();

            // Hacer visible la ventana
            setVisible(true);

        }

        private void initUI() {
            // Panel para contener los componentes
            JPanel panel = new JPanel();
            panel.setLayout(new FlowLayout());

            // Botón para subir archivo
            btnSubirArchivo = new JButton("Subir Archivo");
            btnSubirArchivo.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    JFileChooser fileChooser = new JFileChooser();
                    int returnValue = fileChooser.showOpenDialog(null);
                    if (returnValue == JFileChooser.APPROVE_OPTION) {
                        File selectedFile = fileChooser.getSelectedFile();
                        lblArchivoSeleccionado.setText("Archivo Seleccionado: " + selectedFile.getName());
                    }
                }
            });

            // Etiqueta para mostrar el archivo seleccionado
            lblArchivoSeleccionado = new JLabel("Ningún archivo seleccionado");

            // Añadir componentes al panel
            panel.add(btnSubirArchivo);
            panel.add(lblArchivoSeleccionado);

            // Añadir panel al frame
            this.add(panel);
        }
}

