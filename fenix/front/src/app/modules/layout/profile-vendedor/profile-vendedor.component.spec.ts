import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProfileVendedorComponent } from './profile-vendedor.component';

describe('ProfileVendedorComponent', () => {
  let component: ProfileVendedorComponent;
  let fixture: ComponentFixture<ProfileVendedorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProfileVendedorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProfileVendedorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
