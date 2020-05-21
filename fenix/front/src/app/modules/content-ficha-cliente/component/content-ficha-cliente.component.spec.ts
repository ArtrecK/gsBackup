import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentFichaClienteComponent } from './content-ficha-cliente.component';

describe('ContentFichaClienteComponent', () => {
  let component: ContentFichaClienteComponent;
  let fixture: ComponentFixture<ContentFichaClienteComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentFichaClienteComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentFichaClienteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
