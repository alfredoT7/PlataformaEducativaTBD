/*
package UI.PostCredenciales.Estudiante;

import BD.ComBD;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EntregaUI extends JFrame {

    private ComBD conn;
    private int id_estudiante;
    private String tarea;
    private VerDetalleDeTareaUI ventanaAnterior;
    private JFileChooser fileChooser;
    private File archivoSeleccionado;

    public EntregaUI(ComBD conn, int id_estudiante, String tarea, VerDetalleDeTareaUI ventanaAnterior) {
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        this.tarea = tarea;
        this.ventanaAnterior = ventanaAnterior;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Entrega de Tarea");
        setSize(400, 200);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        fileChooser = new JFileChooser();

        JButton seleccionarArchivoButton = new JButton("Seleccionar Archivo");
        seleccionarArchivoButton.addActionListener(e -> {
            int returnVal = fileChooser.showOpenDialog(EntregaUI.this);
            if (returnVal == JFileChooser.APPROVE_OPTION) {
                archivoSeleccionado = fileChooser.getSelectedFile();

            }
        });

        JButton entregarButton = new JButton("Entregar");
        entregarButton.addActionListener(e -> entregarTarea());

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            ventanaAnterior.setVisible(true);
            setVisible(false);
        });

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        buttonPanel.add(seleccionarArchivoButton);
        buttonPanel.add(entregarButton);
        buttonPanel.add(volverButton);

        add(buttonPanel, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void entregarTarea() {

        if (archivoSeleccionado != null) {
            try {
                byte[] archivoBytes = leerArchivoComoBytes(archivoSeleccionado);
                conn.insertarEntregaTarea(id_estudiante, obtenerIdTarea(tarea), archivoBytes);
                JOptionPane.showMessageDialog(this, "Tarea entregada con éxito");
                dispose();
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Error al leer el archivo", "Error", JOptionPane.ERROR_MESSAGE);
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(this, "Error al guardar la tarea en la base de datos", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un archivo para entregar", "Alerta", JOptionPane.WARNING_MESSAGE);
        }

    }

    private byte[] leerArchivoComoBytes(File archivo) throws IOException {
        FileInputStream fis = new FileInputStream(archivo);
        byte[] buffer = new byte[fis.available()];
        fis.read(buffer);
        fis.close();
        return buffer;
    }

    private int obtenerIdTarea(String tarea) {
        return Integer.parseInt(tarea.substring(1, tarea.indexOf(',')));
    }
}

 */
package UI.PostCredenciales.Estudiante;

import BD.ComBD;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

public class EntregaUI extends JFrame {

    private ComBD conn;
    private int id_estudiante;
    private String tarea;
    private VerDetalleDeTareaUI ventanaAnterior;
    private JLabel archivoLabel;
    private File archivoSeleccionado;

    public EntregaUI(ComBD conn, int id_estudiante, String tarea, VerDetalleDeTareaUI ventanaAnterior) {
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        this.tarea = tarea;
        this.ventanaAnterior = ventanaAnterior;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Entrega de Tarea");
        setSize(400, 200);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        archivoLabel = new JLabel("No se ha seleccionado un archivo.");
        JButton seleccionarArchivoButton = new JButton("Seleccionar Archivo");
        seleccionarArchivoButton.addActionListener(e -> seleccionarArchivo());

        JButton entregarButton = new JButton("Entregar");
        entregarButton.addActionListener(e -> entregarTarea());

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            ventanaAnterior.setVisible(true);
                this.setVisible(false);
        });

        JPanel archivoPanel = new JPanel();
        archivoPanel.add(archivoLabel);

        JPanel botonesPanel = new JPanel();
        botonesPanel.add(seleccionarArchivoButton);
        botonesPanel.add(entregarButton);
        botonesPanel.add(volverButton);

        add(archivoPanel, BorderLayout.NORTH);
        add(botonesPanel, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void seleccionarArchivo() {
        JFileChooser fileChooser = new JFileChooser();
        int returnVal = fileChooser.showOpenDialog(EntregaUI.this);
        if (returnVal == JFileChooser.APPROVE_OPTION) {
            archivoSeleccionado = fileChooser.getSelectedFile();
            archivoLabel.setText("Archivo seleccionado: " + archivoSeleccionado.getName());
        }
    }

    private void entregarTarea() {
        if (archivoSeleccionado != null) {
            try {
                byte[] archivoBytes = leerArchivoComoBytes(archivoSeleccionado);
                boolean retrasoEntrega = false;
                int idEntrega = conn.insertarEntrega(retrasoEntrega, archivoBytes);

                if (idEntrega != -1) {
                    int idTarea = obtenerIdTarea(tarea);
                    java.util.Date fechaEntregaUtil = new java.util.Date();
                    java.sql.Date fechaEntregaSql = new java.sql.Date(fechaEntregaUtil.getTime());
                    conn.insertar_tarea_entrega(idTarea, idEntrega, fechaEntregaSql);
                    conn.insertar_estudiante_entrega(id_estudiante, idEntrega);

                    JOptionPane.showMessageDialog(this, "Tarea entregada con éxito. ID de entrega: " + idEntrega);
                    ventanaAnterior.setVisible(true);
                    dispose();
                } else {
                    JOptionPane.showMessageDialog(this, "No se pudo registrar la entrega", "Error", JOptionPane.ERROR_MESSAGE);
                }
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Error al leer el archivo", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un archivo para entregar", "Alerta", JOptionPane.WARNING_MESSAGE);
        }
    }


    private byte[] leerArchivoComoBytes(File archivo) throws IOException {
        FileInputStream fis = new FileInputStream(archivo);
        byte[] buffer = new byte[fis.available()];
        fis.read(buffer);
        fis.close();
        return buffer;
    }

    private int obtenerIdTarea(String tarea) {
        return Integer.parseInt(tarea.substring(1, tarea.indexOf(',')));
    }
}





























