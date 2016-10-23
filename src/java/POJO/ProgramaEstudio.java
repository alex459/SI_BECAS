/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "programa_estudio")
@NamedQueries({
    @NamedQuery(name = "ProgramaEstudio.findAll", query = "SELECT p FROM ProgramaEstudio p")})
public class ProgramaEstudio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_PROGRAMA_ESTUDIO")
    private Integer idProgramaEstudio;
    @Column(name = "SEMESTRE")
    private Integer semestre;
    @Size(max = 1024)
    @Column(name = "PROGRAMA_ESTUDIO")
    private String programaEstudio;
    @JoinColumn(name = "ID_SOLICITUD", referencedColumnName = "ID_SOLICITUD")
    @ManyToOne
    private SolicitudDeBeca idSolicitud;

    public ProgramaEstudio() {
    }

    public ProgramaEstudio(Integer idProgramaEstudio) {
        this.idProgramaEstudio = idProgramaEstudio;
    }

    public Integer getIdProgramaEstudio() {
        return idProgramaEstudio;
    }

    public void setIdProgramaEstudio(Integer idProgramaEstudio) {
        this.idProgramaEstudio = idProgramaEstudio;
    }

    public Integer getSemestre() {
        return semestre;
    }

    public void setSemestre(Integer semestre) {
        this.semestre = semestre;
    }

    public String getProgramaEstudio() {
        return programaEstudio;
    }

    public void setProgramaEstudio(String programaEstudio) {
        this.programaEstudio = programaEstudio;
    }

    public SolicitudDeBeca getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(SolicitudDeBeca idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idProgramaEstudio != null ? idProgramaEstudio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProgramaEstudio)) {
            return false;
        }
        ProgramaEstudio other = (ProgramaEstudio) object;
        if ((this.idProgramaEstudio == null && other.idProgramaEstudio != null) || (this.idProgramaEstudio != null && !this.idProgramaEstudio.equals(other.idProgramaEstudio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.ProgramaEstudio[ idProgramaEstudio=" + idProgramaEstudio + " ]";
    }
    
}
