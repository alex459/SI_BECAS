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
@Table(name = "referencias")
@NamedQueries({
    @NamedQuery(name = "Referencias.findAll", query = "SELECT r FROM Referencias r")})
public class Referencias implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_REFERENCIA")
    private Integer idReferencia;
    @Size(max = 15)
    @Column(name = "NOMBRE1_DU")
    private String nombre1Du;
    @Size(max = 15)
    @Column(name = "NOMBRE2_DU")
    private String nombre2Du;
    @Size(max = 15)
    @Column(name = "APELLIDO1_DU")
    private String apellido1Du;
    @Size(max = 15)
    @Column(name = "APELLIDO2_DU")
    private String apellido2Du;
    @Size(max = 50)
    @Column(name = "DOMICILIO")
    private String domicilio;
    @Size(max = 9)
    @Column(name = "TELEFONO_MOVIL")
    private String telefonoMovil;
    @JoinColumn(name = "ID_SOLICITUD", referencedColumnName = "ID_SOLICITUD")
    @ManyToOne
    private SolicitudDeBeca idSolicitud;
    @JoinColumn(name = "ID_MUNICIPIO", referencedColumnName = "ID_MUNICIPIO")
    @ManyToOne
    private Municipio idMunicipio;

    public Referencias() {
    }

    public Referencias(Integer idReferencia) {
        this.idReferencia = idReferencia;
    }

    public Integer getIdReferencia() {
        return idReferencia;
    }

    public void setIdReferencia(Integer idReferencia) {
        this.idReferencia = idReferencia;
    }

    public String getNombre1Du() {
        return nombre1Du;
    }

    public void setNombre1Du(String nombre1Du) {
        this.nombre1Du = nombre1Du;
    }

    public String getNombre2Du() {
        return nombre2Du;
    }

    public void setNombre2Du(String nombre2Du) {
        this.nombre2Du = nombre2Du;
    }

    public String getApellido1Du() {
        return apellido1Du;
    }

    public void setApellido1Du(String apellido1Du) {
        this.apellido1Du = apellido1Du;
    }

    public String getApellido2Du() {
        return apellido2Du;
    }

    public void setApellido2Du(String apellido2Du) {
        this.apellido2Du = apellido2Du;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getTelefonoMovil() {
        return telefonoMovil;
    }

    public void setTelefonoMovil(String telefonoMovil) {
        this.telefonoMovil = telefonoMovil;
    }

    public SolicitudDeBeca getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(SolicitudDeBeca idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Municipio getIdMunicipio() {
        return idMunicipio;
    }

    public void setIdMunicipio(Municipio idMunicipio) {
        this.idMunicipio = idMunicipio;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idReferencia != null ? idReferencia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Referencias)) {
            return false;
        }
        Referencias other = (Referencias) object;
        if ((this.idReferencia == null && other.idReferencia != null) || (this.idReferencia != null && !this.idReferencia.equals(other.idReferencia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Referencias[ idReferencia=" + idReferencia + " ]";
    }
    
}
