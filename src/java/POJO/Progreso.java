/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "progreso")
@NamedQueries({
    @NamedQuery(name = "Progreso.findAll", query = "SELECT p FROM Progreso p")})
public class Progreso implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_PROGRESO")
    private Integer idProgreso;
    @Size(max = 50)
    @Column(name = "NOMBRE_PROGRESO")
    private String nombreProgreso;
    @Size(max = 1024)
    @Column(name = "DESCRIPCION_PROGRESO")
    private String descripcionProgreso;
    @Size(max = 15)
    @Column(name = "ESTADO_BECARIO")
    private String estadoBecario;
    @Size(max = 15)
    @Column(name = "ESTADO_PROGRESO")
    private String estadoProgreso;
    @OneToMany(mappedBy = "idProgreso")
    private Set<Expediente> expedienteSet;

    public Progreso() {
    }

    public Progreso(Integer idProgreso) {
        this.idProgreso = idProgreso;
    }

    public Integer getIdProgreso() {
        return idProgreso;
    }

    public void setIdProgreso(Integer idProgreso) {
        this.idProgreso = idProgreso;
    }

    public String getNombreProgreso() {
        return nombreProgreso;
    }

    public void setNombreProgreso(String nombreProgreso) {
        this.nombreProgreso = nombreProgreso;
    }

    public String getDescripcionProgreso() {
        return descripcionProgreso;
    }

    public void setDescripcionProgreso(String descripcionProgreso) {
        this.descripcionProgreso = descripcionProgreso;
    }

    public String getEstadoBecario() {
        return estadoBecario;
    }

    public void setEstadoBecario(String estadoBecario) {
        this.estadoBecario = estadoBecario;
    }

    public String getEstadoProgreso() {
        return estadoProgreso;
    }

    public void setEstadoProgreso(String estadoProgreso) {
        this.estadoProgreso = estadoProgreso;
    }

    public Set<Expediente> getExpedienteSet() {
        return expedienteSet;
    }

    public void setExpedienteSet(Set<Expediente> expedienteSet) {
        this.expedienteSet = expedienteSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idProgreso != null ? idProgreso.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Progreso)) {
            return false;
        }
        Progreso other = (Progreso) object;
        if ((this.idProgreso == null && other.idProgreso != null) || (this.idProgreso != null && !this.idProgreso.equals(other.idProgreso))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Progreso[ idProgreso=" + idProgreso + " ]";
    }
    
}
