package UI.PostCredenciales.Docente;

import BD.ComBD;
import BD.TareaEntregada;
import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class VerDetalleTareasEntregadas extends JFrame {
    private ComBD conn;
    private int id_docente;
    private VentanaCredenciales ventanaCredenciales;
    public VerDetalleTareasEntregadas(ComBD conn, int id_docente, VentanaCredenciales ventanaCredenciales) {
        this.ventanaCredenciales = ventanaCredenciales;
        this.conn = conn;
        this.id_docente = id_docente;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Detalle de Tareas Entregadas");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        JPanel entregasPanel = new JPanel();
        entregasPanel.setLayout(new BoxLayout(entregasPanel, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(entregasPanel);
        scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        add(scrollPane, BorderLayout.CENTER);

        ArrayList<TareaEntregada> tareasEntregadas = conn.obtenerTareasEntregadasDocente(id_docente);
        for (TareaEntregada tarea : tareasEntregadas) {
            JPanel tareaPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
            tareaPanel.add(new JLabel(tarea.getNombreTarea() + " - " + tarea.getNombreEstudiante()));

            JButton descargarButton = new JButton("Descargar");
            descargarButton.addActionListener(e -> descargarArchivo(tarea.getNombreArchivo()));
            tareaPanel.add(descargarButton);

            entregasPanel.add(tareaPanel);
        }

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            ventanaCredenciales.setVisible(true);
            dispose();
        });
        add(volverButton, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void descargarArchivo(String nombreArchivo) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setSelectedFile(new File(nombreArchivo));
        if (fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION) {
            File fileToSave = fileChooser.getSelectedFile();
            // Aquí asumimos que ya existe un archivo con el nombre dado, guardado en el sistema de archivos
            try (FileInputStream fis = new FileInputStream(nombreArchivo);
                 FileOutputStream fos = new FileOutputStream(fileToSave)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) > 0) {
                    fos.write(buffer, 0, bytesRead);
                }
                JOptionPane.showMessageDialog(this, "Archivo guardado con éxito: " + fileToSave.getAbsolutePath());
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Error al guardar el archivo.", "Error", JOptionPane.ERROR_MESSAGE);
                ex.printStackTrace();
            }
        }
    }

    private void calificarTarea(int idTarea) {

        JOptionPane.showMessageDialog(this, "Calificar tarea: " + idTarea);
    }
}