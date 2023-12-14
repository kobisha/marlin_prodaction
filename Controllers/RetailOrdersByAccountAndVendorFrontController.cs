﻿using Marlin.sqlite.Data;
using Marlin.sqlite.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Marlin.sqlite.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class RetailOrdersByAccountAndVendorFrontController : ControllerBase
    {
        private readonly DataContext _context;

        public RetailOrdersByAccountAndVendorFrontController(DataContext context)
        {
            _context = context;
        }

        [HttpGet("{RetailID}/{VendorID}")]
        public IActionResult GetData(string AccountID, string VendorID)
        {
            try
            {
                var query = @"
                  SELECT

    oh.""Id"",

    oh.""AccountID"",

    oh.""OrderID"",

   TO_CHAR(oh.""Date"", 'YYYY-MM-DD HH:MI:SS') as ""Date"",

    oh.""Number"",

    oh.""ReceiverID"" AS ""VendorID"",

    ac.""Name""  AS ""Vendor"",

    s.""Name"" AS ""Shop"",

    max(oh.""Amount"") as ""Amount"",

    Sum(ih.""Amount"") as ""InvoiceAmount"",

    st.""StatusName"" AS ""Status"",

   TO_CHAR( (Cast(oh.""Date"" as Date) + INTERVAL '3 days'), 'YYYY-MM-DD HH:MI:SS') AS ""Scheduled""

FROM public.""OrderHeaders"" oh

LEFT JOIN public.""InvoiceHeaders"" ih on oh.""OrderID"" = ih.""OrderID""

LEFT JOIN public.""Shops"" s ON oh.""ShopID"" = s.""ShopID""

LEFT JOIN public.""OrderStatus"" st ON oh.""StatusID"" = st.""Id""

LEFT JOIN public.""Accounts"" ac ON oh.""ReceiverID""  = ac.""AccountID""

where oh.""AccountID"" = @AccountID and oh.""ReceiverID"" = @VendorID

group by oh.""Id"",

    oh.""AccountID"",

    oh.""OrderID"",

   TO_CHAR(oh.""Date"", 'YYYY-MM-DD HH:MI:SS'),

    oh.""Number"",

    oh.""ReceiverID"",

    ac.""Name"",

    s.""Name"",

    st.""StatusName""";

        var parameters = new[]
                {
                    new Npgsql.NpgsqlParameter("@VendorID", VendorID),
                    new Npgsql.NpgsqlParameter("@AccountID", AccountID)
                };

                var data = _context.Set<OrderFront>().FromSqlRaw(query, parameters).ToList();

                var response = new
                {
                    Data = data
                };

                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(new { error = e.Message });
            }
        }
    }
}
