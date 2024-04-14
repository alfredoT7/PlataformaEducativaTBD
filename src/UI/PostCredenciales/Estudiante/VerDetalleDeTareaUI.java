package UI.PostCredenciales.Estudiante;

import BD.ComBD;
import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class VerDetalleDeTareaUI extends JFrame {

    private JPanel tareasPanel;
    private ComBD conn;
    private int id_estudiante;
    private VentanaCredenciales ventanaCredenciales;

    public VerDetalleDeTareaUI(ComBD conn, int id_estudiante, VentanaCredenciales ventanaCredenciales) {
        this.ventanaCredenciales = ventanaCredenciales;
        this.conn = conn;
        this.id_estudiante = id_estudiante;
        initializeUI();
    }

    private void initializeUI() {
        setTitle("Detalle de Tareas");
        setSize(400, 400);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        tareasPanel = new JPanel();
        tareasPanel.setLayout(new BoxLayout(tareasPanel, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(tareasPanel);
        scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        add(scrollPane, BorderLayout.CENTER);

        cargarTareasEstudiante();

        JButton volverButton = new JButton("Volver");
        volverButton.addActionListener(e -> {
            dispose();
            ventanaCredenciales.setVisible(true);
        });
        add(volverButton, BorderLayout.SOUTH);

        //setVisible(true);
    }

    private void cargarTareasEstudiante() {
        ArrayList<String> tareas = conn.obtener_tareas_por_cod_estudiant(id_estudiante);

        for (String tarea : tareas) {
            JPanel tareaPanel = new JPanel();
            tareaPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
            tareaPanel.add(new JLabel(tarea));

            JButton botonEntregar = new JButton("Entregar");
            botonEntregar.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    // Aquí podrías llamar a otro método para manejar la entrega de la tarea.
                    // Por ejemplo: conn.entregarTarea(id_estudiante, obtenerIdTarea(tarea));
                    EntregaUI entregaUI = new EntregaUI(conn,id_estudiante,tarea, VerDetalleDeTareaUI.this);
                    entregaUI.setVisible(true);
                    setVisible(false);
                    //JOptionPane.showMessageDialog(null, "Entrega realizada para la tarea: " + tarea);
                }
            });

            tareaPanel.add(botonEntregar);
            tareasPanel.add(tareaPanel);
        }

        tareasPanel.revalidate();
        tareasPanel.repaint();
    }
    private int obtenerIdTarea(String tarea) {
        return Integer.parseInt(tarea.substring(1, tarea.indexOf(',')));
    }
}
