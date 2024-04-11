package UI.PostCredenciales.Docente;

import BD.ComBD;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CrearTareaUI extends JFrame {

    private MostrarMateriasDictadasUI mostrarMateriasDictadasUI;
    private String materiaInfo;
    private JTextField nombreTareaField;
    private JTextField fechaAsignacionField;
    private JTextField fechaEntregaField;
    private JTextField periodoAcademicoField;
    private JTextArea descripcionArea;

    public CrearTareaUI(MostrarMateriasDictadasUI mostrarMateriasDictadasUI, String materia, ComBD conn, int id_doc) {
        this.mostrarMateriasDictadasUI = mostrarMateriasDictadasUI;
        this.materiaInfo = materia;

        setTitle("Crear Tarea para " + materia);
        setSize(400, 350); // Ajuste el tamaño para acomodar el nuevo campo.
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(6, 2)); // Modificado para acomodar un campo más.

        add(new JLabel("Nombre de la tarea:"));
        nombreTareaField = new JTextField();
        add(nombreTareaField);

        add(new JLabel("Fecha de asignación:"));
        fechaAsignacionField = new JTextField();
        add(fechaAsignacionField);

        add(new JLabel("Fecha de entrega:"));
        fechaEntregaField = new JTextField();
        add(fechaEntregaField);


        add(new JLabel("Período académico:"));
        periodoAcademicoField = new JTextField();
        add(periodoAcademicoField);

        add(new JLabel("Descripción:"));
        descripcionArea = new JTextArea();
        add(new JScrollPane(descripcionArea));

        JButton crearButton = new JButton("Crear");
        crearButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String nombreTarea = nombreTareaField.getText();
                String descripcionTarea = descripcionArea.getText();
                String periodoAcademico = periodoAcademicoField.getText();
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                try {
                    Date fechaAsignacion = formatter.parse(fechaAsignacionField.getText());
                    Date fechaEntrega = formatter.parse(fechaEntregaField.getText());
                    int tareaId = conn.crearTarea(nombreTarea, new java.sql.Date(fechaAsignacion.getTime()), new java.sql.Date(fechaEntrega.getTime()), descripcionTarea);
                    if (tareaId != -1) {
                        int id_materia = Integer.parseInt(materiaInfo.replaceAll("[^0-9]", ""));
                        conn.insertar_materia_tarea(id_materia, id_doc, tareaId, periodoAcademico);
                        JOptionPane.showMessageDialog(CrearTareaUI.this, "Tarea creada con éxito. ID: " + tareaId);
                    } else {
                        JOptionPane.showMessageDialog(CrearTareaUI.this, "Error al crear la tarea.", "Error", JOptionPane.ERROR_MESSAGE);
                    }

                } catch (ParseException pe) {
                    pe.printStackTrace();
                    JOptionPane.showMessageDialog(CrearTareaUI.this, "Por favor ingrese las fechas en formato dd/MM/yyyy", "Error de Formato", JOptionPane.ERROR_MESSAGE);
                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    JOptionPane.showMessageDialog(CrearTareaUI.this, "Formato de materia no es válido", "Error de Formato", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(crearButton);

        JButton cancelButton = new JButton("Volver");
        cancelButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                mostrarMateriasDictadasUI.setVisible(true);
                dispose();
            }
        });
        add(cancelButton);

        //setVisible(true);
    }
}