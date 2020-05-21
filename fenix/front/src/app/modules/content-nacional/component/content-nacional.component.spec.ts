import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentNacionalComponent } from './content-nacional.component';

describe('ContentNacionalComponent', () => {
  let component: ContentNacionalComponent;
  let fixture: ComponentFixture<ContentNacionalComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentNacionalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentNacionalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
