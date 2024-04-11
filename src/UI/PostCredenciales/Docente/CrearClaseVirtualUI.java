package UI.PostCredenciales.Docente;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import BD.ComBD;
import UI.VentanaCredenciales;

public class CrearClaseVirtualUI extends JFrame {

    private JTextField nombreMateriaField;
    private JTextArea descripcionArea;
    private JButton enviarButton;
    private JButton atrasButton;
    private ComBD conn;
    private int id_user;

    public CrearClaseVirtualUI(ComBD conn, int id_user, VentanaCredenciales ventanaCredenciales) {
        this.conn = conn;
        this.id_user = id_user;
        setTitle("Crear Materia");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());
        setLocationRelativeTo(null);

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new BoxLayout(inputPanel, BoxLayout.Y_AXIS));

        JPanel nombrePanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        nombrePanel.add(new JLabel("Nombre de la materia:"));
        nombreMateriaField = new JTextField(20);
        nombrePanel.add(nombreMateriaField);
        inputPanel.add(nombrePanel);

        JPanel descripcionPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        descripcionPanel.add(new JLabel("Descripción:"));
        descripcionArea = new JTextArea(5, 20);
        JScrollPane scrollPane = new JScrollPane(descripcionArea);
        scrollPane.setPreferredSize(new Dimension(250, 100));
        descripcionPanel.add(scrollPane);
        inputPanel.add(descripcionPanel);

        add(inputPanel, BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));

        atrasButton = new JButton("Atrás");
        buttonPanel.add(atrasButton);
        enviarButton = new JButton("Enviar");
        buttonPanel.add(enviarButton);

        add(buttonPanel, BorderLayout.SOUTH);

        atrasButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                CrearClaseVirtualUI.this.dispose(); // Cierra esta ventana. Ajusta según sea necesario.
                // Si necesitas regresar a una ventana anterior, aquí iría el código.
                ventanaCredenciales.setVisible(true);
            }
        });

        enviarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String nombreMateria = nombreMateriaField.getText();
                String descripcion = descripcionArea.getText();
                conn.insertarMateria(id_user, nombreMateria, descripcion);
                JOptionPane.showMessageDialog(CrearClaseVirtualUI.this, "Materia " + nombreMateria + " creada con éxito!");
            }
        });

        setVisible(true); // Es mejor llamar a setVisible después de haber agregado todos los componentes.
    }
}