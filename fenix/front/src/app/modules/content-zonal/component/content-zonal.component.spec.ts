import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentZonalComponent } from './content-zonal.component';

describe('ContentZonalComponent', () => {
  let component: ContentZonalComponent;
  let fixture: ComponentFixture<ContentZonalComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentZonalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentZonalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
