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
  it("click on product", () => {
      cy.get('.products article').eq(0).click();
      cy.url().should('eq', 'http://localhost:3000/products/12');
  });
})