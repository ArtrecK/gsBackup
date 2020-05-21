import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentGerenteComponent } from './content-gerente.component';

describe('ContentGerenteComponent', () => {
  let component: ContentGerenteComponent;
  let fixture: ComponentFixture<ContentGerenteComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentGerenteComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentGerenteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
