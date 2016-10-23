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
@Table(name = "idioma")
@NamedQueries({
    @NamedQuery(name = "Idioma.findAll", query = "SELECT i FROM Idioma i")})
public class Idioma implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_IDIOMA")
    private Integer idIdioma;
    @Size(max = 20)
    @Column(name = "IDIOMA")
    private String idioma;
    @Size(max = 15)
    @Column(name = "NIVEL_HABLA")
    private String nivelHabla;
    @Size(max = 15)
    @Column(name = "NIVEL_LECTURA")
    private String nivelLectura;
    @Size(max = 15)
    @Column(name = "NIVEL_ESCRITO")
    private String nivelEscrito;
    @JoinColumn(name = "ID_DETALLE_USUARIO", referencedColumnName = "ID_DETALLE_USUARIO")
    @ManyToOne
    private DetalleUsuario idDetalleUsuario;

    public Idioma() {
    }

    public Idioma(Integer idIdioma) {
        this.idIdioma = idIdioma;
    }

    public Integer getIdIdioma() {
        return idIdioma;
    }

    public void setIdIdioma(Integer idIdioma) {
        this.idIdioma = idIdioma;
    }

    public String getIdioma() {
        return idioma;
    }

    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    public String getNivelHabla() {
        return nivelHabla;
    }

    public void setNivelHabla(String nivelHabla) {
        this.nivelHabla = nivelHabla;
    }

    public String getNivelLectura() {
        return nivelLectura;
    }

    public void setNivelLectura(String nivelLectura) {
        this.nivelLectura = nivelLectura;
    }

    public String getNivelEscrito() {
        return nivelEscrito;
    }

    public void setNivelEscrito(String nivelEscrito) {
        this.nivelEscrito = nivelEscrito;
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
        hash += (idIdioma != null ? idIdioma.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Idioma)) {
            return false;
        }
        Idioma other = (Idioma) object;
        if ((this.idIdioma == null && other.idIdioma != null) || (this.idIdioma != null && !this.idIdioma.equals(other.idIdioma))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Idioma[ idIdioma=" + idIdioma + " ]";
    }
    
}
