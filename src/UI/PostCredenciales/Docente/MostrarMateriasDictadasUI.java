package UI.PostCredenciales.Docente;
import BD.ComBD;
import UI.VentanaCredenciales;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class MostrarMateriasDictadasUI extends JFrame {

    private JButton volverButton;
    private JPanel materiasPanel;
    public ComBD conn;
    private int id_doc;

    public MostrarMateriasDictadasUI(ArrayList<String> materiasDictadas, VentanaCredenciales ventanaCredenciales, ComBD conn, int id_doc) {
        this.id_doc=id_doc;
        this.conn=conn;
        setTitle("Materias Dictadas");
        setSize(500, 300);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        materiasPanel = new JPanel();
        materiasPanel.setLayout(new BoxLayout(materiasPanel, BoxLayout.Y_AXIS));
        JScrollPane scrollPane = new JScrollPane(materiasPanel);
        add(scrollPane, BorderLayout.CENTER);

        for (String materia : materiasDictadas) {
            JPanel materiaPanel = new JPanel();
            materiaPanel.setLayout(new FlowLayout(FlowLayout.LEFT));

            materiaPanel.add(new JLabel(materia));

            JButton tareaButton = new JButton("Crear Tarea");
            tareaButton.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    // Lógica para crear la tarea
                    CrearTareaUI crearTareaUI=new CrearTareaUI(MostrarMateriasDictadasUI.this, materia, conn,id_doc);
                    setVisible(false);
                    crearTareaUI.setVisible(true);
                }
            });
            materiaPanel.add(tareaButton);

            materiasPanel.add(materiaPanel);
        }

        volverButton = new JButton("Volver");
        volverButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                //MostrarMateriasDictadasUI.this.dispose();
                setVisible(false);
                ventanaCredenciales.setVisible(true);
            }
        });

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        buttonPanel.add(volverButton);
        add(buttonPanel, BorderLayout.SOUTH);

        setVisible(true);
    }
}