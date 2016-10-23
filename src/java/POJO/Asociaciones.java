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
@Table(name = "asociaciones")
@NamedQueries({
    @NamedQuery(name = "Asociaciones.findAll", query = "SELECT a FROM Asociaciones a")})
public class Asociaciones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_ASOCIACION")
    private Integer idAsociacion;
    @Size(max = 100)
    @Column(name = "NOMBRE_ASOCIACION")
    private String nombreAsociacion;
    @JoinColumn(name = "ID_DETALLE_USUARIO", referencedColumnName = "ID_DETALLE_USUARIO")
    @ManyToOne
    private DetalleUsuario idDetalleUsuario;

    public Asociaciones() {
    }

    public Asociaciones(Integer idAsociacion) {
        this.idAsociacion = idAsociacion;
    }

    public Integer getIdAsociacion() {
        return idAsociacion;
    }

    public void setIdAsociacion(Integer idAsociacion) {
        this.idAsociacion = idAsociacion;
    }

    public String getNombreAsociacion() {
        return nombreAsociacion;
    }

    public void setNombreAsociacion(String nombreAsociacion) {
        this.nombreAsociacion = nombreAsociacion;
    }

    public DetalleUsuario getIdDetalleUsuario() {
        return idDetalleUsuario;
    }

    public void setIdDetalleUsuario(DetalleUsuario idDetalleUsuario) {
        this.idDetalleUsuario = idDetalleUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAsociacion != null ? idAsociacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Asociaciones)) {
            return false;
        }
        Asociaciones other = (Asociaciones) object;
        if ((this.idAsociacion == null && other.idAsociacion != null) || (this.idAsociacion != null && !this.idAsociacion.equals(other.idAsociacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Asociaciones[ idAsociacion=" + idAsociacion + " ]";
    }
    
}
