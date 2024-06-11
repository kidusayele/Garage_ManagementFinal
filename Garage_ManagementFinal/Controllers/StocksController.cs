using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Garage_ManagementFinal;

namespace Garage_ManagementFinal.Controllers
{
    public class StocksController : Controller
    {
        private GaragedbEntities db = new GaragedbEntities();

        // GET: Stocks

        [Authorize(Roles = "StockManager")]
        public ActionResult Index()
        {
            return View(db.Stocks.ToList());
        }
        [Authorize(Roles = "Admin")]
        public ActionResult ViewAdmin()
        {
            ViewBag.SuccessMessage = TempData["SuccessMessage"];
            return View(db.Stocks.ToList());
        }
        // GET: Stocks/Details/5
        [Authorize(Roles = "StockManager")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }

        [Authorize(Roles = "Admin")]
        // GET: Stocks/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Stocks/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public ActionResult Create([Bind(Include = "Id,name,quantity,price,type")] Stock stock)
        {
            if (ModelState.IsValid)
            {
                db.Stocks.Add(stock);
                db.SaveChanges();
                TempData["SuccessMessage"] = "SuccessFuly Insert";
                return RedirectToAction("View_toAdmin");
            }

            return View(stock);
        }
        [Authorize(Roles = "Admin")]
        // GET: Stocks/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }

        // POST: Stocks/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,name,quantity,price,type")] Stock stock)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stock).State = System.Data.Entity.EntityState.Modified;

                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stock);
        }
        [Authorize(Roles = "Admin")]
        // GET: Stocks/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }

        // POST: Stocks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Stock stock = db.Stocks.Find(id);
            try
            {
                db.Stocks.Remove(stock);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                TempData["SuccessMessage"] = "Please delete First from orders!";
                return RedirectToAction("Index");
            }
        }

        [Authorize(Roles = "StockManager")]
        public async Task<ActionResult> Viewadd(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = await db.Stocks.FindAsync(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]

        public async Task<ActionResult> Viewadd([Bind(Include = "Id,name,quantity,price,type")] Stock stock, int id)
        {

            using (var context = new GaragedbEntities())
            {

                var product = context.Stocks.Find(id);
                if (product != null)
                {
                    decimal m = Convert.ToDecimal(Request["quantity"]);
                    decimal l = System.Convert.ToDecimal(product.quantity);
                    decimal sum = m + l;
                    product.quantity = System.Convert.ToDouble(sum);
                    context.SaveChanges();
                    decimal quantity = m;
                    decimal price = Convert.ToDecimal(Request["price"]);
                    decimal buyprice = Convert.ToDecimal(Request["buy_price"]);
                    decimal Total_price = m * buyprice;

                    int ids = id;
                    DateTime currentDate = DateTime.Now;



                    if (ModelState.IsValid)
                    {
                        purchase purchase = new purchase();
                        purchase.old_quantity = System.Convert.ToDouble(l);
                        purchase.new_quantity = System.Convert.ToDouble(m);
                        purchase.remain_quantity = System.Convert.ToDouble(sum);
                        purchase.price = System.Convert.ToDouble(buyprice);
                        purchase.total_price = System.Convert.ToDouble(Total_price);
                        purchase.date = DateTime.Now;
                        purchase.StockId = ids;
                        db.purchases.Add(purchase);
                        await db.SaveChangesAsync();
                        return RedirectToAction("Index", "purchases");
                    }

                    return View("Index");
                    /* Savetodatabase(quantity,price,Total_price,DateTime.Now,ids);*/




                }
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
