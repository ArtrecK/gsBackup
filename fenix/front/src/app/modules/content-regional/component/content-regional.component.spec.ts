import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentRegionalComponent } from './content-regional.component';

describe('ContentRegionalComponent', () => {
  let component: ContentRegionalComponent;
  let fixture: ComponentFixture<ContentRegionalComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentRegionalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentRegionalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
