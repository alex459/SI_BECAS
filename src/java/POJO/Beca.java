/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

/**
 *
 * @author next
 */
@Entity
@Table(name = "beca")
@NamedQueries({
    @NamedQuery(name = "Beca.findAll", query = "SELECT b FROM Beca b")})
public class Beca implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_BECA")
    private Integer idBeca;
    @Column(name = "FECHA_INICIO")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;
    @Column(name = "FECHA_FIN")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;
    @JoinColumn(name = "ID_EXPEDIENTE", referencedColumnName = "ID_EXPEDIENTE")
    @ManyToOne(optional = false)
    private Expediente idExpediente;

    public Beca() {
    }

    public Beca(Integer idBeca) {
        this.idBeca = idBeca;
    }

    public Integer getIdBeca() {
        return idBeca;
    }

    public void setIdBeca(Integer idBeca) {
        this.idBeca = idBeca;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Expediente getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Expediente idExpediente) {
        this.idExpediente = idExpediente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idBeca != null ? idBeca.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Beca)) {
            return false;
        }
        Beca other = (Beca) object;
        if ((this.idBeca == null && other.idBeca != null) || (this.idBeca != null && !this.idBeca.equals(other.idBeca))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Beca[ idBeca=" + idBeca + " ]";
    }
    
}
