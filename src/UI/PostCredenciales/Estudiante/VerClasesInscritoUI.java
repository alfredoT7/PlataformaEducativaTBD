package UI.PostCredenciales.Estudiante;

import BD.ComBD;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class VerClasesInscritoUI extends JFrame {

    private JList<String> listaMaterias;
    private ComBD conn;
    private int id_estudiante;

    public VerClasesInscritoUI(ComBD conn, int id_estudiante) {
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        setTitle("Clases Inscritas");
        setSize(300, 400);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        cargarMaterias();

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                VerClasesInscritoUI.this.dispose();
            }
        });
        JPanel southPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        southPanel.add(volverButton);
        add(southPanel, BorderLayout.SOUTH);
        setVisible(true);
    }

    private void cargarMaterias() {
        ArrayList<String> materias = conn.obtener_nombre_materia_por_estudiante(id_estudiante);
        DefaultListModel<String> modeloLista = new DefaultListModel<>();
        for (String materia : materias) {
            String nombreMateria = materia.replaceAll("[\"()0-9,]+", "");
            modeloLista.addElement(nombreMateria);
        }
        listaMaterias = new JList<>(modeloLista);
        listaMaterias.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        JScrollPane scrollPane = new JScrollPane(listaMaterias);
        add(scrollPane, BorderLayout.CENTER);
    }
}