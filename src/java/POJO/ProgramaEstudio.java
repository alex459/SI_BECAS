package POJO;


public class ProgramaEstudio{

    
    private Integer idProgramaEstudio;
    private SolicitudDeBeca idSolicitud;
    private Integer semestre;
    private String programaEstudio;    

    /**
     * @return the idProgramaEstudio
     */
    public Integer getIdProgramaEstudio() {
        return idProgramaEstudio;
    }

    /**
     * @param idProgramaEstudio the idProgramaEstudio to set
     */
    public void setIdProgramaEstudio(Integer idProgramaEstudio) {
        this.idProgramaEstudio = idProgramaEstudio;
    }

    /**
     * @return the idSolicitud
     */
    public SolicitudDeBeca getIdSolicitud() {
        return idSolicitud;
    }

    /**
     * @param idSolicitud the idSolicitud to set
     */
    public void setIdSolicitud(SolicitudDeBeca idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    /**
     * @return the semestre
     */
    public Integer getSemestre() {
        return semestre;
    }

    /**
     * @param semestre the semestre to set
     */
    public void setSemestre(Integer semestre) {
        this.semestre = semestre;
    }

    /**
     * @return the programaEstudio
     */
    public String getProgramaEstudio() {
        return programaEstudio;
    }

    /**
     * @param programaEstudio the programaEstudio to set
     */
    public void setProgramaEstudio(String programaEstudio) {
        this.programaEstudio = programaEstudio;
    }

    
    
}
