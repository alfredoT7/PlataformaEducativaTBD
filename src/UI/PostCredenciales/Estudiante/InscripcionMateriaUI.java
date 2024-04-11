package UI.PostCredenciales.Estudiante;

import BD.ComBD;
import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;

public class InscripcionMateriaUI extends JFrame {

    private JPanel materiasPanel;
    private ComBD conn;
    private int id_estudiante;
    VentanaCredenciales ventanaCredenciales;
    public InscripcionMateriaUI(ComBD conn, int id_estudiante, VentanaCredenciales ventanaCredenciales) {
        this.ventanaCredenciales=ventanaCredenciales;
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Inscripción a Materias");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());
        setSize(new Dimension(400, 600));
        setLocationRelativeTo(null);

        materiasPanel = new JPanel();
        materiasPanel.setLayout(new BoxLayout(materiasPanel, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(materiasPanel);
        add(scrollPane, BorderLayout.CENTER);

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            setVisible(false);
            ventanaCredenciales.setVisible(true);
        });
        add(volverButton, BorderLayout.SOUTH);

        cargarMateriasDisponibles();

        setVisible(true);
    }

    private void cargarMateriasDisponibles() {
        ArrayList<String> materiasDisponibles = conn.obtener_materia_docente_por_estudiante_excluyendo(id_estudiante);

        for (String materia : materiasDisponibles) {
            JPanel filaMateria = new JPanel(new FlowLayout(FlowLayout.LEFT));
            filaMateria.setAlignmentX(Component.LEFT_ALIGNMENT);

            JLabel labelMateria = new JLabel(materia);
            JButton botonInscribirse = new JButton("Inscribirse");

            botonInscribirse.addActionListener(e -> {

            });

            filaMateria.add(labelMateria);
            filaMateria.add(botonInscribirse);
            materiasPanel.add(filaMateria);
        }
    }
    private int obtenerIdMateria(String materia) {
        return Integer.parseInt(materia.substring(1, materia.indexOf(',')));
    }
    private String obtenerNombreMateria(String materia) {
        return materia.substring(materia.indexOf(',') + 1, materia.length() - 1).trim();
    }
}