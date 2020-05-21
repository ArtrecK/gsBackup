import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-alerts',
  templateUrl: './alerts.component.html',
  styleUrls: ['./alerts.component.scss']
})
export class AlertsComponent implements OnInit {

  constructor() { }

  public sAlertasExpandir = true;
  public sAlertasIconoMinimizar = 'assets/img/maximizar.png';

  ngOnInit() {
  }


  cambiaComponenteAlertas() {
    this.sAlertasExpandir = !this.sAlertasExpandir;
    if (this.sAlertasExpandir) {
      this.sAlertasIconoMinimizar = 'assets/img/maximizar.png';
      document.getElementById('container').className = 'alertas';
      document.getElementById('iconoExp').className = 'maximizar';
    } else {
      this.sAlertasIconoMinimizar = 'assets/img/minimizar.png';
      document.getElementById('container').className = 'alertmax';
      document.getElementById('iconoExp').className = 'minimizar';
    }
  }
 }
