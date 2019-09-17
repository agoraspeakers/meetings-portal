import './navigation.scss';

class Navigation {
  static setActiveItem(): void {
    const currentItem: HTMLAnchorElement = this.currentItem();
    currentItem.classList.add('active');
  }

  static currentItem(): HTMLAnchorElement {
    const queryAnchor = `ul li a[href='${window.location.pathname}']`;
    return document.getElementById('top-navigation').querySelector(queryAnchor);
  }
}

export default Navigation;
