package UI.PostCredenciales.Estudiante;

import BD.ComBD;
import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class InscripcionMateriaUI extends JFrame {

    private JPanel materiasPanel;
    private ComBD conn;
    private int id_estudiante;
    private VentanaCredenciales ventanaCredenciales;
    public InscripcionMateriaUI(ComBD conn, int id_estudiante, VentanaCredenciales ventanaCredenciales) {
        this.ventanaCredenciales=ventanaCredenciales;
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Inscripción a Materias");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(400, 300);
        setLocationRelativeTo(null);
        setResizable(false);

        materiasPanel = new JPanel();
        materiasPanel.setLayout(new BoxLayout(materiasPanel, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(materiasPanel);
        scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        add(scrollPane);

        cargarMateriasDisponibles();

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            setVisible(false);
            ventanaCredenciales.setVisible(true);
        });
        add(volverButton, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void cargarMateriasDisponibles() {
        ArrayList<String> materiasDisponibles = conn.obtener_materias_no_inscritas(id_estudiante);

        for (String materia : materiasDisponibles) {
            String[] partes = materia.split(",");
            String idMateria = partes[0].substring(1).trim();
            String idDocente = partes[1].trim();
            String nombreMateria = partes[2].substring(0, partes[2].length() - 1).trim().replace("\"", "");

            JPanel filaMateria = new JPanel();
            filaMateria.setLayout(new FlowLayout(FlowLayout.LEFT));
            filaMateria.add(new JLabel(nombreMateria));

            JButton botonInscribirse = new JButton("Inscribirse");
            botonInscribirse.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    conn.insertar_inscripcion(Integer.parseInt(idMateria), Integer.parseInt(idDocente), id_estudiante, "I-2024");
                    JOptionPane.showMessageDialog(null, "Inscripción realizada: " + nombreMateria);
                    dispose();
                    new InscripcionMateriaUI(conn, id_estudiante,ventanaCredenciales);
                }
            });

            filaMateria.add(botonInscribirse);
            materiasPanel.add(filaMateria);
        }

        materiasPanel.revalidate();
        materiasPanel.repaint();
    }
}