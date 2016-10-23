/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
@Table(name = "institucion")
@NamedQueries({
    @NamedQuery(name = "Institucion.findAll", query = "SELECT i FROM Institucion i")})
public class Institucion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_INSTITUCION")
    private Integer idInstitucion;
    @Size(max = 100)
    @Column(name = "NOMBRE_INSTITUCION")
    private String nombreInstitucion;
    @Size(max = 20)
    @Column(name = "TIPO_INSTITUCION")
    private String tipoInstitucion;
    @Size(max = 20)
    @Column(name = "PAIS")
    private String pais;
    @Size(max = 100)
    @Column(name = "PAGINA_WEB")
    private String paginaWeb;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Correo electrónico no válido")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 30)
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "INSTITUCION_ACTIVA")
    private Boolean institucionActiva;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idInstitucionEstudio")
    private Set<OfertaBeca> ofertaBecaSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idInstitucionFinanciera")
    private Set<OfertaBeca> ofertaBecaSet1;

    public Institucion() {
    }

    public Institucion(Integer idInstitucion) {
        this.idInstitucion = idInstitucion;
    }

    public Integer getIdInstitucion() {
        return idInstitucion;
    }

    public void setIdInstitucion(Integer idInstitucion) {
        this.idInstitucion = idInstitucion;
    }

    public String getNombreInstitucion() {
        return nombreInstitucion;
    }

    public void setNombreInstitucion(String nombreInstitucion) {
        this.nombreInstitucion = nombreInstitucion;
    }

    public String getTipoInstitucion() {
        return tipoInstitucion;
    }

    public void setTipoInstitucion(String tipoInstitucion) {
        this.tipoInstitucion = tipoInstitucion;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getPaginaWeb() {
        return paginaWeb;
    }

    public void setPaginaWeb(String paginaWeb) {
        this.paginaWeb = paginaWeb;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getInstitucionActiva() {
        return institucionActiva;
    }

    public void setInstitucionActiva(Boolean institucionActiva) {
        this.institucionActiva = institucionActiva;
    }

    public Set<OfertaBeca> getOfertaBecaSet() {
        return ofertaBecaSet;
    }

    public void setOfertaBecaSet(Set<OfertaBeca> ofertaBecaSet) {
        this.ofertaBecaSet = ofertaBecaSet;
    }

    public Set<OfertaBeca> getOfertaBecaSet1() {
        return ofertaBecaSet1;
    }

    public void setOfertaBecaSet1(Set<OfertaBeca> ofertaBecaSet1) {
        this.ofertaBecaSet1 = ofertaBecaSet1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idInstitucion != null ? idInstitucion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Institucion)) {
            return false;
        }
        Institucion other = (Institucion) object;
        if ((this.idInstitucion == null && other.idInstitucion != null) || (this.idInstitucion != null && !this.idInstitucion.equals(other.idInstitucion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Institucion[ idInstitucion=" + idInstitucion + " ]";
    }
    
}
