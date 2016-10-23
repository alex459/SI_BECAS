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
@Table(name = "investigaciones")
@NamedQueries({
    @NamedQuery(name = "Investigaciones.findAll", query = "SELECT i FROM Investigaciones i")})
public class Investigaciones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_INVESTIGACION")
    private Integer idInvestigacion;
    @Size(max = 100)
    @Column(name = "TITULO_INVESTIGACION")
    private String tituloInvestigacion;
    @Column(name = "PUBLICADO")
    private Boolean publicado;
    @JoinColumn(name = "ID_DETALLE_USUARIO", referencedColumnName = "ID_DETALLE_USUARIO")
    @ManyToOne
    private DetalleUsuario idDetalleUsuario;

    public Investigaciones() {
    }

    public Investigaciones(Integer idInvestigacion) {
        this.idInvestigacion = idInvestigacion;
    }

    public Integer getIdInvestigacion() {
        return idInvestigacion;
    }

    public void setIdInvestigacion(Integer idInvestigacion) {
        this.idInvestigacion = idInvestigacion;
    }

    public String getTituloInvestigacion() {
        return tituloInvestigacion;
    }

    public void setTituloInvestigacion(String tituloInvestigacion) {
        this.tituloInvestigacion = tituloInvestigacion;
    }

    public Boolean getPublicado() {
        return publicado;
    }

    public void setPublicado(Boolean publicado) {
        this.publicado = publicado;
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
        hash += (idInvestigacion != null ? idInvestigacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Investigaciones)) {
            return false;
        }
        Investigaciones other = (Investigaciones) object;
        if ((this.idInvestigacion == null && other.idInvestigacion != null) || (this.idInvestigacion != null && !this.idInvestigacion.equals(other.idInvestigacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Investigaciones[ idInvestigacion=" + idInvestigacion + " ]";
    }
    
}
