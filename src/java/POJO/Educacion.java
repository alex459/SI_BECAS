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
@Table(name = "educacion")
@NamedQueries({
    @NamedQuery(name = "Educacion.findAll", query = "SELECT e FROM Educacion e")})
public class Educacion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_EDUCACION")
    private Integer idEducacion;
    @Size(max = 20)
    @Column(name = "TIPO_EDUCACION")
    private String tipoEducacion;
    @Size(max = 30)
    @Column(name = "GRADO_ALCANZADO")
    private String gradoAlcanzado;
    @Size(max = 100)
    @Column(name = "NOMBRE_INSTITUCION")
    private String nombreInstitucion;
    @Column(name = "ANIO")
    private Integer anio;
    @JoinColumn(name = "ID_DETALLE_USUARIO", referencedColumnName = "ID_DETALLE_USUARIO")
    @ManyToOne
    private DetalleUsuario idDetalleUsuario;

    public Educacion() {
    }

    public Educacion(Integer idEducacion) {
        this.idEducacion = idEducacion;
    }

    public Integer getIdEducacion() {
        return idEducacion;
    }

    public void setIdEducacion(Integer idEducacion) {
        this.idEducacion = idEducacion;
    }

    public String getTipoEducacion() {
        return tipoEducacion;
    }

    public void setTipoEducacion(String tipoEducacion) {
        this.tipoEducacion = tipoEducacion;
    }

    public String getGradoAlcanzado() {
        return gradoAlcanzado;
    }

    public void setGradoAlcanzado(String gradoAlcanzado) {
        this.gradoAlcanzado = gradoAlcanzado;
    }

    public String getNombreInstitucion() {
        return nombreInstitucion;
    }

    public void setNombreInstitucion(String nombreInstitucion) {
        this.nombreInstitucion = nombreInstitucion;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
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
        hash += (idEducacion != null ? idEducacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Educacion)) {
            return false;
        }
        Educacion other = (Educacion) object;
        if ((this.idEducacion == null && other.idEducacion != null) || (this.idEducacion != null && !this.idEducacion.equals(other.idEducacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Educacion[ idEducacion=" + idEducacion + " ]";
    }
    
}
