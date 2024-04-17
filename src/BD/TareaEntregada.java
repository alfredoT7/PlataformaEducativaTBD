package BD;

public class TareaEntregada {
    private int idTarea;
    private String nombreTarea;
    private String nombreMateria;
    private String nombreEstudiante;
    private String nombreArchivo;

    public TareaEntregada(int idTarea, String nombreTarea, String nombreMateria, String nombreEstudiante, String nombreArchivo) {
        this.idTarea = idTarea;
        this.nombreTarea = nombreTarea;
        this.nombreMateria = nombreMateria;
        this.nombreEstudiante = nombreEstudiante;
        this.nombreArchivo = nombreArchivo;
    }
    public int getIdTarea() { return idTarea; }
    public String getNombreTarea() { return nombreTarea; }
    public String getNombreMateria() { return nombreMateria; }
    public String getNombreEstudiante() { return nombreEstudiante; }
    public String getNombreArchivo() { return nombreArchivo; }

}