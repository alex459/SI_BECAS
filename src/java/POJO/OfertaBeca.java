/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "oferta_beca")
@NamedQueries({
    @NamedQuery(name = "OfertaBeca.findAll", query = "SELECT o FROM OfertaBeca o")})
public class OfertaBeca implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_OFERTA_BECA")
    private Integer idOfertaBeca;
    @Size(max = 100)
    @Column(name = "NOMBRE_OFERTA")
    private String nombreOferta;
    @Size(max = 10)
    @Column(name = "TIPO_OFERTA_BECA")
    private String tipoOfertaBeca;
    @Column(name = "DURACION")
    private Integer duracion;
    @Column(name = "FECHA_CIERRE")
    @Temporal(TemporalType.DATE)
    private Date fechaCierre;
    @Size(max = 20)
    @Column(name = "MODALIDAD")
    private String modalidad;
    @Column(name = "FECHA_INICIO")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;
    @Size(max = 20)
    @Column(name = "IDIOMA")
    private String idioma;
    @Size(max = 20)
    @Column(name = "FINANCIAMIENTO")
    private String financiamiento;
    @Size(max = 2000)
    @Column(name = "PERFIL")
    private String perfil;
    @Column(name = "FECHA_INGRESO")
    @Temporal(TemporalType.DATE)
    private Date fechaIngreso;
    @Size(max = 15)
    @Column(name = "TIPO_ESTUDIO")
    private String tipoEstudio;
    @Column(name = "OFERTA_BECA_ACTIVA")
    private Boolean ofertaBecaActiva;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOfertaBeca")
    private Set<SolicitudDeBeca> solicitudDeBecaSet;
    @JoinColumn(name = "ID_INSTITUCION_ESTUDIO", referencedColumnName = "ID_INSTITUCION")
    @ManyToOne(optional = false)
    private Institucion idInstitucionEstudio;
    @JoinColumn(name = "ID_INSTITUCION_FINANCIERA", referencedColumnName = "ID_INSTITUCION")
    @ManyToOne(optional = false)
    private Institucion idInstitucionFinanciera;
    @JoinColumn(name = "ID_DOCUMENTO", referencedColumnName = "ID_DOCUMENTO")
    @ManyToOne(optional = false)
    private Documento idDocumento;

    public OfertaBeca() {
    }

    public OfertaBeca(Integer idOfertaBeca) {
        this.idOfertaBeca = idOfertaBeca;
    }

    public Integer getIdOfertaBeca() {
        return idOfertaBeca;
    }

    public void setIdOfertaBeca(Integer idOfertaBeca) {
        this.idOfertaBeca = idOfertaBeca;
    }

    public String getNombreOferta() {
        return nombreOferta;
    }

    public void setNombreOferta(String nombreOferta) {
        this.nombreOferta = nombreOferta;
    }

    public String getTipoOfertaBeca() {
        return tipoOfertaBeca;
    }

    public void setTipoOfertaBeca(String tipoOfertaBeca) {
        this.tipoOfertaBeca = tipoOfertaBeca;
    }

    public Integer getDuracion() {
        return duracion;
    }

    public void setDuracion(Integer duracion) {
        this.duracion = duracion;
    }

    public Date getFechaCierre() {
        return fechaCierre;
    }

    public void setFechaCierre(Date fechaCierre) {
        this.fechaCierre = fechaCierre;
    }

    public String getModalidad() {
        return modalidad;
    }

    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getIdioma() {
        return idioma;
    }

    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    public String getFinanciamiento() {
        return financiamiento;
    }

    public void setFinanciamiento(String financiamiento) {
        this.financiamiento = financiamiento;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getTipoEstudio() {
        return tipoEstudio;
    }

    public void setTipoEstudio(String tipoEstudio) {
        this.tipoEstudio = tipoEstudio;
    }

    public Boolean getOfertaBecaActiva() {
        return ofertaBecaActiva;
    }

    public void setOfertaBecaActiva(Boolean ofertaBecaActiva) {
        this.ofertaBecaActiva = ofertaBecaActiva;
    }

    public Set<SolicitudDeBeca> getSolicitudDeBecaSet() {
        return solicitudDeBecaSet;
    }

    public void setSolicitudDeBecaSet(Set<SolicitudDeBeca> solicitudDeBecaSet) {
        this.solicitudDeBecaSet = solicitudDeBecaSet;
    }

    public Institucion getIdInstitucionEstudio() {
        return idInstitucionEstudio;
    }

    public void setIdInstitucionEstudio(Institucion idInstitucionEstudio) {
        this.idInstitucionEstudio = idInstitucionEstudio;
    }

    public Institucion getIdInstitucionFinanciera() {
        return idInstitucionFinanciera;
    }

    public void setIdInstitucionFinanciera(Institucion idInstitucionFinanciera) {
        this.idInstitucionFinanciera = idInstitucionFinanciera;
    }

    public Documento getIdDocumento() {
        return idDocumento;
    }

    public void setIdDocumento(Documento idDocumento) {
        this.idDocumento = idDocumento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idOfertaBeca != null ? idOfertaBeca.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OfertaBeca)) {
            return false;
        }
        OfertaBeca other = (OfertaBeca) object;
        if ((this.idOfertaBeca == null && other.idOfertaBeca != null) || (this.idOfertaBeca != null && !this.idOfertaBeca.equals(other.idOfertaBeca))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.OfertaBeca[ idOfertaBeca=" + idOfertaBeca + " ]";
    }
    
}
