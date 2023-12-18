describe('home page', () => {
  it('home page', () => {
    cy.visit('http://localhost:3000/')
  })
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
  it('increment cart by 1', () => {
    cy.get('article button[type="submit"]').first().click({ force: true });
    cy.get('li.nav-item.end-0 .nav-link')
    .invoke('text')
    .then((text) => {
    expect(text).to.include('My Cart (0)');
    });
  });
  
})
