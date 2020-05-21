import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProfileSupervisionComponent } from './profile-supervision.component';

describe('ProfileSupervisionComponent', () => {
  let component: ProfileSupervisionComponent;
  let fixture: ComponentFixture<ProfileSupervisionComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProfileSupervisionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProfileSupervisionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
